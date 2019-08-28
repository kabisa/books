class EbookDecorator < BookDecorator

  def download_link
    h.link_to(object.link, target: '_blank') do
      h.material_icon('cloud_download', h.tooltipify(I18n.t('helpers.submit.download')))
    end
  end
end
