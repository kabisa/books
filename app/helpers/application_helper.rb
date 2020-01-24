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

  def link_to_github
    url     = 'https://github.com/kabisa/books'
    options = tooltipify(I18n.t('view_on_github')).merge(class: 'nav-link', target: '_blank')

    link_to(url, options) do
      capture do
        concat fa_icon('fab', 'github', class: 'mr-3')
        concat 'GitHub'
      end
    end
  end

  def modal_id
    'modal'
  end

  def hamburger_menu(&block)
    return if (menu_items = capture { block.call }).blank?

    content_tag(:div, class: 'ml-3 dropdown', data: { toggle: 'no-collapse' }) do
      concat(tag.button(class:sm_rnd_btn_class, aria: { expanded: false, haspopup: true }, data: { toggle: 'dropdown' }, type: 'button') do
        material_icon('more_vert', tooltipify(t('helpers.options')))
      end)
      concat(content_tag(:div, class: 'dropdown-menu menu dropdown-menu-right') do
        menu_items
      end)
    end
  end

  def icon_placeholder
    material_icon('0')
  end
end
