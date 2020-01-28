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
    h.safe_join [printed_book_icon, ebook_icon]
  end

  def printed_book_icon
    if copies.any?
      h.material_icon('menu_book', h.tooltipify(printed_book_text))
    else
      h.icon_placeholder
    end
  end

  def ebook_icon
    if link?
      h.material_icon('tablet_android', h.tooltipify(ebook_text))
    else
      h.icon_placeholder
    end
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
      h.concat link_to_download
      h.concat link_to_borrow
      h.concat link_to_destroy
    end
  end

  def link_to_edit
    return unless h.policy(object).edit?

    h.tag.li(h.link_to I18n.t('helpers.submit.edit'), h.edit_book_path(object), class: 'dropdown-item')
  end

  def link_to_download
    return unless h.policy(object).download?

    h.tag.li(h.link_to I18n.t('helpers.submit.download'), object.link, class: 'dropdown-item', role: :button, target: '_blank')
  end

  def link_to_borrow
    return unless h.policy(object).borrow?

    borrow_or_return_button
  end

  def link_to_destroy
    return unless h.policy(object).destroy?

    h.capture do
      h.concat(h.tag.li(class: 'dropdown-divider'))
      h.concat(h.tag.li(h.link_to I18n.t('helpers.submit.destroy'), object, method: :delete, remote: true, class: 'dropdown-item text-danger'))
    end
  end

  private

  def borrow_or_return_button
    if borrowed_by?(h.current_user)
      return_button
    else
      borrow_button
    end
  end

  def return_button
    borrowing = borrow_by(h.current_user)

    h.tag.li(h.button_to I18n.t('helpers.submit.borrowing.destroy'), borrowing, method: :delete, remote: true, class: 'dropdown-item')
  end

  def borrow_button
    if copies.borrowables.none?
      borrow_none_button
    elsif copies.borrowables.one?
      borrow_one_button
    else
      borrow_submenu
    end
  end

  def borrow_none_button
    h.tag.li(h.button_tag borrow_label, class: 'dropdown-item', disabled: true)
  end

  def borrow_one_button
    h.tag.li(h.button_to borrow_label, h.borrowings_path(borrowing: { book_id: object, copy_id: copies.borrowables.first }), remote: true, class: 'dropdown-item')
  end

  def borrow_label
    I18n.t('helpers.submit.borrowing.submit')
  end

  def borrow_submenu
    content = h.capture do
      h.concat(h.tag.span(borrow_label, class: 'dropdown-item dropdown-toggle'))
      h.concat(h.tag.ul(submenu_items, class: 'dropdown-menu'))
    end

    h.tag.li(content, class: 'dropdown-submenu')
  end

  def submenu_items
    h.capture do
      copies.borrowables.each do |c|
        h.concat(h.tag.li(h.button_to c.location.to_label, h.borrowings_path(borrowing: { book_id: object, copy_id: c }), remote: true, class: 'dropdown-item'))
      end
    end
  end
end

# (1) Using `comments.size` will not use counter cache. We could also have used `model.comments.size`.
