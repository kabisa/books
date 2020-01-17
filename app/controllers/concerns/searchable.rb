module Searchable
  include ActiveSupport::Concern

  def ransack_params
    if params.dig(:q, :likes_count_gteq)&.to_i == 0
      params[:q].delete(:likes_count_gteq)
    end

    if params.dig(:q, :num_of_pages_gteq)&.to_i == 0
      params[:q].delete(:num_of_pages_gteq)
    end

    if params.dig(:q, :num_of_pages_lteq)&.to_i == Rails.configuration.x.search.num_of_pages_upper
      params[:q].delete(:num_of_pages_lteq)
    end

    q = Book.ransack(params[:q])
    q.sorts = 'title' if q.sorts.empty?

    yield q if block_given?

    q.likes_count_gteq ||= 0
    q.num_of_pages_lteq ||= Rails.configuration.x.search.num_of_pages_upper
    q.num_of_pages_gteq ||= 0

    q
  end
end
