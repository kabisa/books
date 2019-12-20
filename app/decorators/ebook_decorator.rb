class EbookDecorator < BookDecorator

  def download_link
    h.link_to I18n.t('helpers.submit.download'), object.link, class: 'dropdown-item', role: :button, target: '_blank'
  end

  private

  def icon
    'tablet_android'
  end
end
