class BookDecorator < ApplicationDecorator
  include HighlightedWithSearch

  delegate_all
  decorates_association :comments

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def available_copies
    h.pluralize(copies_count - borrowings_count, Copy.model_name.human.downcase)
  end

  def formatted_type
    I18n.t(object.type, scope: 'book_types')
  end

  def type_and_pages
    h.safe_join [formatted_type, formatted_num_of_pages].compact, ', '
  end

  # TODO: Test
  def media_and_pages
    text = []

    if copies.any?
      text << I18n.t('book_types.PrintedBook')
    end

    text << formatted_num_of_pages

    h.safe_join text.compact, ', '
  end

  def formatted_num_of_pages
    return unless num_of_pages?

    I18n.t('num_of_pages', num_of_pages: num_of_pages)
  end

  def formatted_published_on
    return unless published_on?

    I18n.t('published_on', published_on: I18n.l(published_on))
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
    h.tag.small(class: 'text-muted') do
      h.concat h.material_icon('label')
      h.concat ' '
      h.concat tag_list
    end
  end

  def written_by
    return if writers.none?

    I18n.t('activerecord.attributes.book.written_by', writer_names: writer_names.to_sentence)
  end

  def number_of_comments
    [
      comments_count,  # (1)
      Comment.model_name.human.pluralize(comments_count)
    ].join(' ')
  end

  # Return an icon and a number and shows a tooltip
  # @example
  # book.number_of_comments_icon
  # # => <span data-toggle="tooltip" title="17 Comments">
  #        <i class="material-icons">mode_comment</i> 17
  #      </span>
  def number_of_comments_icon
    h.tag.span(
      h.safe_join(
        [
          h.material_icon('mode_comment'),
          comments_count # (1)
        ], ' '),
        h.tooltipify(number_of_comments))

  end

  def book_type_icon
    h.material_icon(icon, h.tooltipify(formatted_type))
  end

  def truncated_summary
    h.truncate(summary, length: 240)
  end

  def truncated_summary_html(options={})
    h.simple_format(truncated_summary, options)
  end

  def hamburger_menu
    h.hamburger_menu do
      h.concat link_to_edit
      h.concat link_to_borrow
      h.concat link_to_destroy
    end
  end

  def link_to_edit
    return unless h.policy(object).edit?

    h.link_to I18n.t('helpers.submit.edit'), h.edit_book_path(object), class: 'dropdown-item'
  end

  def link_to_destroy
    return unless h.policy(object).destroy?

    h.capture do
      h.concat(h.tag.div(class: 'dropdown-divider'))
      h.concat(h.link_to I18n.t('helpers.submit.destroy'), object, method: :delete, remote: true, class: 'dropdown-item text-danger')
    end
  end
end

# (1) Using `comments.size` will not use counter cache. We could also have used `model.comments.size`.
