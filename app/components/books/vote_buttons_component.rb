module Books
  class VoteButtonsComponent < ViewComponent::Base
    include BootstrapHelper

    def initialize(book:, like:, dislike:, like_count:, dislike_count:)
      @book = book
      @like = like
      @dislike = dislike
      @like_count = like_count
      @dislike_count = dislike_count
    end

    private

    attr_reader :book, :like, :dislike, :like_count, :dislike_count
  end
end
