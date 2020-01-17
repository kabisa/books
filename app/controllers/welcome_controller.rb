class WelcomeController < ApplicationController
  def index
    @q = BookSearch.search(params)

    @suggestions = Suggestions.new
  end
end
