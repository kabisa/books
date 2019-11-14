class WelcomeController < ApplicationController
  def index
    @q = ransack_params

    @suggestions = Suggestions.new
  end
end
