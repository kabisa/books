class EbookDecorator < BookDecorator

  def download_link
    h.link_to(object.link, target: '_blank', data: { toggle: 'tooltip' }, title: 'Download') do
      h.content_tag(:i, 'cloud_download', class: 'material-icons')
    end
  end
end
