# This class is a WIP and currently only
# contains 3 suggestions.
# When there is a more relevant use case for 'suggestions'
# we also need to add unit tests for this class.
class Suggestions
  def last_commented_on
    Comment.order(:created_at).last&.book&.decorate
  end

  def recently_added
    Book.order(:created_at).last&.decorate
  end

  def most_likes
    Book.order(:likes_count).last&.decorate
  end

  def any?
    last_commented_on || recently_added || most_likes
  end
end
