module BookComponents
  class PrintedBookIcon < ActionView::Component::Base
    include BootstrapHelper
    include ApplicationHelper

    def initialize(book:, user:)
      @book = book
      @user = user
    end

    private

    attr_reader :book, :user

    def copies?
      book.copies.any?
    end

    def icon_options
      tooltipify(tooltip).merge(class: icon_class)
    end

    def tooltip
      tooltip = [book.printed_book_text]

      if borrowed_by_user?
        tooltip << unsentence_case(I18n.t('you_are_currently_borrowing'))
      elsif !available_copies?
        tooltip << unsentence_case(I18n.t('no_copies_available'))
      end

      safe_join tooltip, ', '
    end

    def icon_class
      if borrowed_by_user?
        'text-primary'
      elsif !available_copies?
        'text-muted'
      end
    end

    def identified_user?
      user.identified?
    end

    def borrowed_by_user?
      @borrowed_by_user ||= book.borrowed_by?(user)
    end

    def available_copies?
      @available_copies ||= book.available_copies.nonzero?
    end

    def unsentence_case(text)
      text[0] = text[0].downcase
      text
    end
  end
end
