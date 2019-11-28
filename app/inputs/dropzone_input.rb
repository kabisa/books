class DropzoneInput < SimpleForm::Inputs::FileInput
  def input(wrapper_options)
    input_html_options.merge!({
      accept: 'image/*',
      data: {
        target: "#{controller}.fileInput",
        action: "#{controller}#handleImage"
      }
    })

    template.tag.div(class: 'dropzone-container img-thumbnail', data: { controller: controller }) do
      template.concat overlay
      template.concat image
      template.concat @builder.input_field(attribute_name, input_html_options)
      template.concat remove_image
      template.concat image_cache
    end
  end


  private
  def controller
    'dropzone'
  end

  def overlay
    template.tag.div(class: 'dropzone-overlay d-flex justify-content-center align-items-center') do
      template.concat add_icon
      template.concat remove_icon
      template.concat backdrop
    end

  end

  def add_icon
    template.link_to '#', class: template.sm_rnd_btn_class('dropzone-action text-light'), data: { action: "#{controller}#browse" } do
      template.material_icon('add_photo_alternate', template.tooltipify(I18n.t('upload', scope: [template.controller.controller_name, template.controller.action_name])))
    end
  end

  def remove_icon
    template.link_to '#', class: template.sm_rnd_btn_class('dropzone-action ml-3 text-light'), data: { target: "#{controller}.removeButton", action: "#{controller}#removeImage" } do
      template.material_icon('close', template.tooltipify(I18n.t('remove', scope: [template.controller.controller_name, template.controller.action_name])))
    end
  end

  def backdrop
    template.tag.div(class: 'dropzone-backdrop')
  end

  def image
    if object.send("#{attribute_name}?")
      template.image_tag object.send("#{attribute_name}_url"), class: 'img-fluid', data: { target: "#{controller}.previewImage" }
    else
      template.tag.img(class: 'img-fluid', data: { target: "#{controller}.previewImage" })
    end
  end

  def remove_image
    @builder.hidden_field("remove_#{attribute_name}".to_sym, data: { target: "#{controller}.removeImage" })
  end

  # https://github.com/carrierwaveuploader/carrierwave#making-uploads-work-across-form-redisplays
  def image_cache
    @builder.hidden_field("#{attribute_name}_cache".to_sym)
  end
end
