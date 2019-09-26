class VoteBar < ActionView::Component::Base

  def initialize(like_count:, dislike_count:, has_voted: false)
    @like_count = like_count
    @dislike_count = dislike_count
    @has_voted = has_voted
  end

  private

  attr_reader :like_count, :dislike_count, :has_voted

  def vote_count
    like_count + dislike_count
  end

  def width
    return 0 if vote_count.zero?

    100*like_count/vote_count
  end

  def progressbar_class
    progressbar_class = %w(progress-bar)
    progressbar_class << (has_voted ? 'bg-secondary' : 'bg-dark')
    progressbar_class
  end
end
