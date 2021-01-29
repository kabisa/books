class BookDecorator < ApplicationDecorator
  include Book::HighlightedWithSearch
  include Book::Icons

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
      formatted_num_of_pages
    ].compact, ', '
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

    h.render(Books::VoteButtonsComponent.new(options))
  end

  def vote_stats
    options = {
      like_count: likes.size,
      dislike_count: dislikes.size
    }

    h.render(Books::VoteStatsComponent.new(options))
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

  def written_by_published_on
    h.safe_join [
      written_by,
      formatted_published_on
    ].compact, ', '
  end

  def number_of_comments
    [
      comments_count,  # (1)
      Comment.model_name.human.pluralize(comments_count)
    ].join(' ')
  end

  def truncated_summary
    h.truncate(summary, length: 240)
  end

  def truncated_summary_html(options = {})
    h.simple_format(truncated_summary, options)
  end

  def hamburger_menu(remote: true)
    options = {
      book: self,
      remote: remote,
      user: h.current_user
    }

    h.render(Books::HamburgerMenuComponent.new(options))
  end

  def currently_borrowing_alert
    if borrowed_by?(h.current_user)
      options = {
        text: I18n.t('you_are_currently_borrowing'),
        type: :info
      }

      h.render(Bootstrap::AlertComponent.new(options))
    end
  end

  def reedition_alert
    if reedition
      options = {
        text: h.link_to(I18n.t('reedition_available'), reedition, class: 'alert-link')
      }

      h.tag.div(h.render(Bootstrap::AlertComponent.new(options)), data: { toggle: 'no-collapse' })
    end
  end

  def reedition_badge
    if reedition
      options = {
        text: I18n.t('outdated'),
        type: :light
      }
      h.tag.small(h.render(Bootstrap::BadgeComponent.new(options)), h.tooltipify(I18n.t('reedition_available')))
    end
  end

  def latest_edition_badge
    if latest_edition?
      options = {
        text: I18n.t('latest'),
        type: :primary
      }
      h.tag.small(h.render(Bootstrap::BadgeComponent.new(options)))
    end
  end
end

# (1) Using `comments.size` will not use counter cache. We could also have used `model.comments.size`.
