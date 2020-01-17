class BookSearch
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
    if params.dig(:q, :likes_count_gteq)&.to_i == 0
      params[:q].delete(:likes_count_gteq)
    end

    if params.dig(:q, :num_of_pages_gteq)&.to_i == 0
      params[:q].delete(:num_of_pages_gteq)
    end

    if params.dig(:q, :num_of_pages_lteq)&.to_i == num_of_pages_upper
      params[:q].delete(:num_of_pages_lteq)
    end
  end

  def revert_params
    q.likes_count_gteq ||= 0
    q.num_of_pages_lteq ||= num_of_pages_upper
    q.num_of_pages_gteq ||= 0
  end

  def num_of_pages_upper
    Rails.configuration.x.search.num_of_pages_upper
  end
end
