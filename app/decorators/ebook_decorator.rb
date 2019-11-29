class EbookDecorator < BookDecorator

  def download_link
    h.link_to I18n.t('helpers.submit.download'), object.link, class: 'btn btn-outline', role: :button, target: '_blank'
  end

  private

  def icon
    'tablet_android'
  end
end
