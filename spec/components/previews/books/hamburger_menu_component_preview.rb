module Books
  class HamburgerMenuComponentPreview < ViewComponent::Preview
    layout 'preview'

    def with_guest_user
      self.book = ebook
      self.user = FactoryBot.build(:guest)
      render_component
    end

    def with_an_ebook
      self.book = ebook
      render_component
    end

    def with_a_printed_book
      self.book = printed_book
      render_component
    end

    private

    attr_accessor :user, :book

    def render_component
      render(HamburgerMenuComponent.new(options))
    end

    def options
      {
        book: book,
        user: user,
        remote: true
      }
    end

    def ebook
      FactoryBot.build(:book, :ebook, id: 42)
    end

    def printed_book
      FactoryBot.build(:book, :printed_book, copies_count: 2, id: 42)
    end

    def user
      @user || FactoryBot.build(:user)
    end
  end
end
