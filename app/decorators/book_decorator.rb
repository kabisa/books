class BookDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def formatted_type
    I18n.t(object.type, scope: 'book_types')
  end

  def title_highlighted_with_search
    h.highlight(title, title_or_summary_cont)
  end

  def summary_highlighted_with_search
    h.highlight(h.simple_format(summary), title_or_summary_cont)
  end

  def dom_id(prefix = nil)
    h.dom_id(object, prefix)
  end

  def vote_buttons
    options = {
      book: object,
      like_count: likes.size,
      dislike_count: dislikes.size,
      like: likes.find_by(user: h.current_user),
      dislike: dislikes.find_by(user: h.current_user)
    }

    h.render(BookComponents::VoteButtons, options)
  end

  def vote_stats
    options = {
      like_count: likes.size,
      dislike_count: dislikes.size
    }

    h.render(BookComponents::VoteStats, options)
  end

  def formatted_tag_list
    h.content_tag(:small, class: 'text-muted') do
      h.concat h.material_icon('label')
      h.concat ' '
      h.concat tag_list
    end
  end

  def number_of_comments
    [
      comments.size,
      Comment.model_name.human.pluralize(comments.size)
    ].join(' ')
  end

  private

  def title_or_summary_cont
    h.params[:q]&.fetch(:title_or_summary_cont)
  end
end
