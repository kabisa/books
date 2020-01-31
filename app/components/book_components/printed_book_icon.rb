module BookComponents
  class PrintedBookIcon < ActionView::Component::Base
    include BootstrapHelper
    include ApplicationHelper

    def initialize(book:)
      @book = book
    end

    private

    attr_reader :book
  end
end

