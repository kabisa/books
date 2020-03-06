class VoteBarPreview < ViewComponent::Preview
  layout 'preview'

  def with_vote_from_user
    self.has_voted = true
    render_component
  end

  def without_vote_from_user
    self.has_voted = false
    render_component
  end

  private

  attr_accessor :has_voted

  def render_component
    render(VoteBar.new(options))
  end

  def options
    {
      like_count: 10,
      dislike_count: 3,
      has_voted: has_voted
    }
  end
end
