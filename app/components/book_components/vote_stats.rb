module BookComponents
  class VoteStats < ViewComponent::Base
    def initialize(like_count:, dislike_count:)
      @like_count = like_count
      @dislike_count = dislike_count
    end

    private

    attr_reader :like_count, :dislike_count

    def total_count
      like_count + dislike_count
    end

    def percentage
      return 0 if total_count.zero?

      100*like_count/total_count
    end

    def popover
      content_tag(:div) do
        concat thumb(:thumb_up, like_count, :dark)
        concat thumb(:thumb_down, dislike_count, 'black-50')
      end
    end

    def thumb(thumb, count, color)
      escape_once(content_tag(:span, class: "text-#{color}") do
        concat escape_once(content_tag(:i, thumb, class: 'material-icons mx-2'))
        concat count
      end)
    end
  end
end
