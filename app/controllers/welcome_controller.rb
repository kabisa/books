class WelcomeController < ApplicationController
  def index
    @q = ransack_params
  end
end
