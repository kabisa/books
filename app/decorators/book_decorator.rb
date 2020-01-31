class BookDecorator < ApplicationDecorator
  include HighlightedWithSearch

  delegate_all
  decorates_association :comments

  def available_copies
    copies_count - borrowings_count
  end

  def formatted_available_copies
    h.pluralize(available_copies, Copy.model_name.human.downcase)
  end

  def media_and_pages
    h.safe_join [
      printed_book_text,
      ebook_text,
      formatted_num_of_pages].compact, ', '
  end

  def printed_book_text
    return if copies.empty?

    I18n.t('book_types.printed_book')
  end

  def ebook_text
    return unless link?

    I18n.t('book_types.e_book')
  end

  def book_type_icon
    h.safe_join [printed_book_icon, ebook_icon]
  end

  def printed_book_icon
    if h.policy(self).borrow?
      options = {
        book: self,
        user: h.current_user
      }

      h.render(BookComponents::PrintedBookIcon, options)
    else
      h.icon_placeholder
    end
  end

  def ebook_icon
    if h.policy(self).download?
      h.material_icon('tablet_android', h.tooltipify(ebook_text))
    else
      h.icon_placeholder
    end
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

  def truncated_summary
    h.truncate(summary, length: 240)
  end

  def truncated_summary_html(options={})
    h.simple_format(truncated_summary, options)
  end

  def hamburger_menu(remote: true)
    options = {
      book: self,
      remote: remote,
      user: h.current_user
    }

    h.render(BookComponents::HamburgerMenu, options)
  end

  def currently_borrowing_alert
    if borrowed_by?(h.current_user)
      h.tag.div(I18n.t('you_are_currently_borrowing'), class: 'alert alert-info')
    end
  end
end

# (1) Using `comments.size` will not use counter cache. We could also have used `model.comments.size`.
