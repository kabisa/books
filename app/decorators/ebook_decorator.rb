class EbookDecorator < BookDecorator
  def link_to_borrow
    return unless h.policy(object).borrow?

    h.link_to I18n.t('helpers.submit.download'), object.link, class: 'dropdown-item', role: :button, target: '_blank'
  end

  private

  def icon
    'tablet_android'
  end
end
