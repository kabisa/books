class WelcomeController < ApplicationController
  def index
    @q = BookSearch.new(params).search

    @suggestions = Suggestions.new
  end
end
