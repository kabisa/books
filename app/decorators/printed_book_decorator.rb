class PrintedBookDecorator < BookDecorator
  def available_copies
    h.pluralize(copies_count - borrowings_count, Copy.model_name.human.downcase)
  end

  def borrow_or_return_button
    if borrowed_by?(h.current_user)
      h.button_tag('Return Book', class: 'btn btn-outline')
    elsif copies.borrowables.none?
      h.button_tag 'Borrow', class: 'btn btn-outline', disabled: true
    elsif copies.borrowables.one?
      h.button_to 'Borrow', h.borrowings_path(borrowing: { book_id: object, copy_id: copies.borrowables.first }), remote: true, class: 'btn btn-outline'
    else
      h.capture do
        h.concat h.link_to 'Borrow...', '#', class: 'btn btn-outline', role: :button, data: { toggle: 'modal', target: "##{h.dom_id(object, :borrow)}" }
        h.concat(h.content_tag(:div, id: h.dom_id(object, :borrow), class: 'modal fade', aria: { hidden: true, labelledby: h.dom_id(object, :label) }, role: :dialog, tabindex: -1) do
          h.content_tag(:div, class: 'modal-dialog', role: :document) do
            h.simple_form_for :borrowing, url: h.borrowings_path, method: :post, remote: true do |f|
              h.concat h.hidden_field(:borrowing, :book_id, value: id)
              h.concat(h.content_tag(:div, class: 'modal-content') do
                h.concat(h.content_tag(:div, class: 'modal-header') do
                  h.content_tag(:h5, "Borrow #{title}", class: 'modal-title', id: h.dom_id(object, :label))
                end)
                h.concat(h.content_tag(:div, class: 'modal-body') do
                  h.concat h.content_tag(:p, 'This book is available on multiple locations.')
                  h.concat f.input :copy_id, include_blank: false, collection: copies.borrowables, label_method: -> (c) { c.location.city }, label: 'Location', required: false
                end)
                h.concat(h.content_tag(:div, class: 'modal-footer') do
                  h.concat h.link_to 'Cancel', '#', class: 'btn', role: :button, data: { dismiss: 'modal' }
                  h.concat f.button :submit, class: 'btn-primary', data: { target: "##{h.dom_id(object, :borrow)}", toggle: 'modal' }
                end)
              end)
            end
          end
        end)
      end
    end
  end
end
