module Searchable
  include ActiveSupport::Concern

  def ransack_params
    q = Book.ransack((params[:q] || {}).with_defaults(default_params))
    q.sorts = 'title' if q.sorts.empty?
    q
  end

  def default_params
    {
      likes_count_gteq: 0
    }
  end
end
