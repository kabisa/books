# This class is a little extension on Ransack::Search.
# When calling `Book.ransack(params[:q])` as suggested by the documentation
# some unexpected things might happen.
# - Books with the fields corresponding to the search keys set to nil
# will be excluded from the search results. E.g. num_of_pages_gteq has a minimum
# value of 0 and since we cannot set to to nil, this key will be used
# to select the books with num_pages attributes set to 0 or higher, although
# we also want to see books without this attribute set. This applies to some
# other attributes as well. For this we remove these keys from the params
# in these special cases (see `remove_params`) before passing them to the `ransack`
# method and add them back afterwards (`revert_params`) so they can be used
# to populate the SearchForm correctly.
# - The order of the books is unexpected (at least for the end-user) if no sorting
# is specified. In this case we sort on the `title` field.
class BookSearch
  NUM_OF_PAGES_UPPER = Rails.configuration.x.search.num_of_pages_upper
  PUBLISHED_YEARS_AGO_UPPER = Rails.configuration.x.search.published_years_ago_upper

  def self.search(params, &block)
    new(params).search(&block)
  end

  def initialize(params)
    @params = params
  end

  def search
    remove_params

    self.q = Book.ransack(params[:q])
    q.sorts = 'title' if q.sorts.empty?

    yield q if block_given?

    revert_params
    q
  end

  private

  attr_reader :params
  attr_accessor :q

  def remove_params
    remove_param(:likes_count_gteq, 0)
    remove_param(:num_of_pages_gteq, 0)
    remove_param(:num_of_pages_lteq, num_of_pages_upper)
    remove_param(:published_years_ago_lteq, 0)
    remove_param(:published_years_ago_gteq, published_years_ago_upper)
  end

  def remove_param(key, value)
    if params.dig(:q, key)&.to_i == value
      params[:q].delete(key)
    end
  end

  def revert_params
    q.likes_count_gteq ||= 0
    q.num_of_pages_lteq ||= num_of_pages_upper
    q.num_of_pages_gteq ||= 0
    q.published_years_ago_lteq ||= 0
    q.published_years_ago_gteq ||= published_years_ago_upper
  end

  def num_of_pages_upper
    NUM_OF_PAGES_UPPER
  end

  def published_years_ago_upper
    PUBLISHED_YEARS_AGO_UPPER
  end
end
