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
end
