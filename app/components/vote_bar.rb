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

  def background
    has_voted ? 'primary' : 'dark'
  end
end
