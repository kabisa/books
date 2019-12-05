module ApplicationHelper
  def app_name
    Rails.application.config.app_name
  end

  def floating_action_button
    return unless policy(Book).new?
    return if current_page?(controller: 'books', action: 'new')

    content_tag(:div, class: 'fab-add') do
      link_to(new_book_path, class: fab_class('btn-secondary'), role: :button) do
        content_tag(:i, 'add', class: 'material-icons')
      end
    end
  end

  def show_more_link_to(scope, name, options={})
    disable_with      = safe_join([tag.div(spinner, class: 'spinner-container'), name], ' ')
    icon              = material_icon('keyboard_arrow_down')
    name              = safe_join([icon, name], ' ')

    options.merge!({
      data: { disable_with: disable_with }
    })

    link_to_next_page scope, name, options
  end

  def decorated_sort_link(search_object, attribute, *args, &block)
    args[0] ||= {}
    args[1] ||= {}
    args[1].merge!({ class: 'dropdown-item d-flex flex-row-reverse justify-content-end' })
    sort_link(search_object, attribute, *args, block)
  end
end
