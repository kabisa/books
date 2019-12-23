class PrintedBookDecorator < BookDecorator
  def available_copies
    h.pluralize(copies_count - borrowings_count, Copy.model_name.human.downcase)
  end

  def borrow_or_return_button
    if borrowed_by?(h.current_user)
      return_button
    else
      borrow_button
    end
  end

  private

  def return_button
    borrowing = borrow_by(h.current_user)

    h.button_to I18n.t('helpers.submit.borrowing.destroy'), borrowing, method: :delete, remote: true, class: 'dropdown-item'
  end

  def borrow_button
    if copies.borrowables.none?
      borrow_none_button
    elsif copies.borrowables.one?
      borrow_one_button
    else
      borrow_modal_button
    end
  end

  def borrow_none_button
    h.button_tag borrow_label, class: 'dropdown-item', disabled: true
  end

  def borrow_one_button
    h.button_to borrow_label, h.borrowings_path(borrowing: { book_id: object, copy_id: copies.borrowables.first }), remote: true, class: 'dropdown-item'
  end

  def borrow_modal_button
    h.button_to "#{borrow_label}...", h.borrowings_path(borrowing: { book_id: object }), remote: true, class: 'dropdown-item'
  end

  def icon
    'menu_book'
  end

  def borrow_link
    if h.policy(object).borrow?
      borrow_or_return_button
    end
  end

  private

  def borrow_label
    I18n.t('helpers.submit.borrowing.submit')
  end
end
