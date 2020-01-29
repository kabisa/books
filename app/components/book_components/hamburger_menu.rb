module BookComponents
  class HamburgerMenu < ActionView::Component::Base
    include BootstrapHelper
    include ApplicationHelper

    delegate :edit?, :download?, :borrow?, :destroy?, to: :policy
    delegate :copies, to: :book
    delegate :borrowables, to: :copies

    def initialize(book:, remote:, user:)
      @book = book
      @remote = remote
      @user = user
    end

    private

    attr_reader :book, :remote, :user

    def policy
      Pundit.policy(user, book)
    end

    def borrowing
      book.borrow_by(user)
    end

    def borrow_label
      I18n.t('helpers.submit.borrowing.submit')
    end

    def item_class
      'dropdown-item'
    end
  end
end
