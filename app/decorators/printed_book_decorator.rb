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

    h.button_to I18n.t('helpers.submit.borrowing.destroy'), borrowing, method: :delete, remote: true, class: 'btn btn-outline'
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
    h.button_tag borrow_label, class: 'btn btn-outline', disabled: true
  end

  def borrow_one_button
    h.button_to borrow_label, h.borrowings_path(borrowing: { book_id: object, copy_id: copies.borrowables.first }), remote: true, class: 'btn btn-outline'
  end

  def borrow_modal_button
    h.button_to "#{borrow_label}...", h.borrowings_path(borrowing: { book_id: object }), remote: true, class: 'btn btn-outline'
    #h.capture do
      #h.concat h.link_to "#{borrow_label}...", '#', class: 'btn btn-outline', role: :button, data: { toggle: 'modal', target: "##{data_target}" }
      #h.concat borrow_modal
    #end
  end

  def borrow_modal
    h.content_tag(:div, id: data_target, class: 'modal fade', aria: { hidden: true, labelledby: aria_labelledby }, role: :dialog, tabindex: -1) do
      h.content_tag(:div, class: 'modal-dialog', role: :document) do
        h.simple_form_for :borrowing, url: h.borrowings_path, method: :post, remote: true do |f|
          h.concat(h.content_tag(:div, class: 'modal-content') do
            h.concat(h.content_tag(:div, class: 'modal-header') do
              h.content_tag(:h5, I18n.t(:title, title: title, scope: %i(modals borrow)), class: 'modal-title', id: aria_labelledby)
            end)
            h.concat(h.content_tag(:div, class: 'modal-body') do
              h.concat h.content_tag(:p, I18n.t(:content, scope: %i(modals borrow)))
              h.concat f.input :copy_id, include_blank: false, collection: copies.borrowables, label_method: -> (c) { c.location.city }, label: 'Location', required: false
            end)
            h.concat(h.content_tag(:div, class: 'modal-footer') do
              h.concat h.link_to I18n.t('helpers.submit.cancel'), '#', class: 'btn', role: :button, data: { dismiss: 'modal' }
              h.concat f.button :submit, class: 'btn btn-primary', data: { target: "##{data_target}", toggle: 'modal' }
            end)
          end)
        end
      end
    end
  end

  def borrow_label
    I18n.t('helpers.submit.borrowing.submit')
  end

  def data_target
    h.dom_id(object, :borrow)
  end

  def aria_labelledby
    h.dom_id(object, :label)
  end

  def icon
    'menu_book'
  end
end
