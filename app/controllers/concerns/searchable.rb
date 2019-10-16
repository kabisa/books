module Searchable
  include ActiveSupport::Concern

  def ransack_params
    Book.ransack(params[:q])
  end
end
