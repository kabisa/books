class WriterDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def first_book_title_and_more
    return if books.none?

    sorted_books = books.sort_by(&:title)
    title = sorted_books.shift.title
    title += " +#{sorted_books.size}" if sorted_books.any?
    title
  end
end
