module BookComponents
  class HamburgerMenu < ActionView::Component::Base
    include BootstrapHelper
    include ApplicationHelper

    def initialize(book:, user:)
      @book = book
      @user = user
    end

    private

    attr_reader :book, :user

    def policy
      Pundit.policy(user, book)
    end

    def edit?
      policy.edit?
    end

    def download?
      policy.download?
    end

    def borrow?
      policy.borrow?
    end

    def destroy?
      policy.destroy?
    end

    def borrowing
      book.borrow_by(user)
    end

    def borrow_label
      I18n.t('helpers.submit.borrowing.submit')
    end
  end
end
