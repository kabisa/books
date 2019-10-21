module Searchable
  include ActiveSupport::Concern

  def ransack_params
    Book.ransack((params[:q] || {}).with_defaults(default_params))
  end

  def default_params
    {
      likes_count_gteq: 0
    }
  end
end
