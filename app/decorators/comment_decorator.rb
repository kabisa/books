class CommentDecorator < ApplicationDecorator
  delegate_all
  delegate :commenter, to: :user
  decorates_association :user

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def truncated_body
    h.truncate(body, length: 120)
  end

  def truncated_body_html
    h.simple_format(truncated_body)
  end

  def commenter_html
    h.tag.small do
      h.concat commenter_badge
      h.concat ' '
      h.concat h.tag.span(formatted_created_at, class: 'text-black-secondary')
    end
  end

  private

  def commenter_badge

    if user.current_user?
      options = {
        content: commenter,
        type: :light
      }

      h.render(Bootstrap::Badge, options)
    else
      h.tag.strong(commenter)
    end
  end
end
