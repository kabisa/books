module Books
  class HamburgerMenuComponent < ViewComponent::Base
    include BootstrapHelper
    include ApplicationHelper

    delegate :edit?, :download?, :borrow?, :destroy?, to: :policy
    delegate :copies, to: :book
    delegate :borrowables, to: :copies

    def initialize(book:, show:, singly:, user:)
      @book = book
      @show = show
      @singly = singly
      @user = user
    end

    private

    attr_reader :book, :show, :singly, :user

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

    def singly?
      !!singly
    end

    def show?
      !!show
    end
  end
end
