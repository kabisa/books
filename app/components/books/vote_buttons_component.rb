module Books
  class VoteButtonsComponent < ViewComponent::Base
    include BootstrapHelper

    def initialize(book:, like:, dislike:, like_count:, dislike_count:, show:)
      @book = book
      @like = like
      @dislike = dislike
      @like_count = like_count
      @dislike_count = dislike_count
      @show = show
    end

    private

    attr_reader :book, :like, :dislike, :like_count, :dislike_count

    def show?
      !!@show
    end
  end
end
