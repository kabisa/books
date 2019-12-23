class EbookDecorator < BookDecorator
  def borrow_link
    if h.policy(object).borrow?
      h.link_to I18n.t('helpers.submit.download'), object.link, class: 'dropdown-item', role: :button, target: '_blank'
    end
  end

  private

  def icon
    'tablet_android'
  end
end
