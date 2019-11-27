class DropzoneInput < SimpleForm::Inputs::FileInput
  def input(wrapper_options)
    input_html_options.merge!({
      accept: 'image/*',
      data: {
        target: 'dropzone.fileInput',
        action: 'dropzone#handleImage'
      }
    })
    template.content_tag(:div, class: 'dropzone-container img-thumbnail', data: { controller: 'dropzone' }) do
      template.concat overlay
      template.concat image
      template.concat super
      template.concat remove_image
    end
  end


  private

  def overlay
    template.tag.div(class: 'dropzone-overlay d-flex justify-content-center align-items-center') do
      template.concat icon1
      template.concat icon2
      template.concat template.tag.div(class: 'dropzone-backdrop')
    end

  end

  def icon1
    template.link_to '#', class: template.sm_rnd_btn_class('uploader-action text-light'), data: { action: 'dropzone#browse' } do
      template.material_icon('add_photo_alternate', template.tooltipify(I18n.t('upload', scope: [template.controller.controller_name, template.controller.action_name])))
    end
  end

  def icon2
    template.link_to '#', class: template.sm_rnd_btn_class('uploader-action ml-3 text-light'), data: { target: 'dropzone.removeButton', action: 'dropzone#removeImage' } do
      template.material_icon('close', template.tooltipify(I18n.t('remove', scope: [template.controller.controller_name, template.controller.action_name])))
    end
  end

  def image
    if object.send("#{attribute_name}?")
      template.image_tag object.send("#{attribute_name}_url"), class: 'img-fluid', data: { target: 'dropzone.previewImage' }
    else
      template.tag.img(class: 'img-fluid', data: { target: 'dropzone.previewImage' })
    end
  end

  def remove_image
    @builder.hidden_field("remove_#{attribute_name}".to_sym, data: { target: 'dropzone.removeCover' })
  end
end
