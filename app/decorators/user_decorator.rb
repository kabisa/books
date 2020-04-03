class UserDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def destroy_link
    if current_user?
      h.link_to I18n.t('users.user.destroy'), '#', class: 'btn btn-danger disabled'
    else
      h.link_to I18n.t('users.user.destroy'), self, method: :delete, class: 'btn btn-danger', data: { confirm: I18n.t('users.user.confirm', name: self) }
    end
  end

  def to_label
    return name if name.present?

    email
  end
  alias to_s to_label

  def role_word
    I18n.t("role/#{role}", scope: [:activerecord, :attributes, :user])
  end

  def commenter
    if comments_anonymously? && !current_user?
      I18n.t('anonymous')
    else
      email
    end
  end

  def current_user?
    self == h.current_user
  end

  def secure_avatar_thumbnail
    thumb = avatar.thumb
    source = comments_anonymously? ? thumb.default_url : thumb.url
    h.image_tag(source, class: 'img-fluid rounded-circle')
  end
end
