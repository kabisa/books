class WelcomeController < ApplicationController
  def index
    @q = Book.ransack(params[:q])

  end
end
