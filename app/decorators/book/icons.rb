module Book::Icons
  def book_type_icon
    h.safe_join [printed_book_icon, ebook_icon]
  end

  def printed_book_icon
    if h.policy(self).borrow?
      options = {
        book: self,
        user: h.current_user
      }

      h.render(Books::PrintedBookIconComponent.new(**options))
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
        ], ' '
      ),
      **h.tooltipify(number_of_comments)
    )
  end
end

# (1) Using `comments.size` will not use counter cache. We could also have used `model.comments.size`.
