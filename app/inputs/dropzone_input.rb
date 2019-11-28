class DropzoneInput < SimpleForm::Inputs::FileInput
  def input(wrapper_options)
    input_html_options.merge!({
      accept: 'image/*',
      data: {
        target: "#{data_controller}.fileInput",
        action: "#{data_controller}#handleImage"
      }
    })

    template.tag.div(class: 'dropzone-container img-thumbnail', data: { controller: data_controller }) do
      template.concat overlay
      template.concat image
      # `@builder.input` (or `self`) renders a wrapper div we do not need.
      template.concat @builder.input_field(attribute_name, input_html_options)
      template.concat remove_image
      template.concat image_cache
    end
  end


  private
  def data_controller
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
    template.link_to '#', class: template.sm_rnd_btn_class('dropzone-action text-light'), data: { action: "dragover->#{data_controller}#acceptDrag drop->#{data_controller}#noop #{data_controller}#browse" } do
      template.material_icon('add_photo_alternate', template.tooltipify(I18n.t('upload', scope: [template.controller.controller_name, template.controller.action_name])))
    end
  end

  def remove_icon
    template.link_to '#', class: template.sm_rnd_btn_class('dropzone-action ml-3 text-light'), data: { target: "#{data_controller}.removeButton", action: "dragover->#{data_controller}#acceptDrag drop->#{data_controller}#noop #{data_controller}#removeImage" } do
      template.material_icon('close', template.tooltipify(I18n.t('remove', scope: [template.controller.controller_name, template.controller.action_name])))
    end
  end

  def backdrop
    template.tag.div(class: 'dropzone-backdrop')
  end

  def image
    options = {
      class: 'img-fluid w-100',
      data: {
        target: "#{data_controller}.previewImage"
      }
    }

    if object.send("#{attribute_name}?")
      template.image_tag object.send("#{attribute_name}_url"), options
    else
      template.tag.img(options)
    end
  end

  def remove_image
    @builder.hidden_field("remove_#{attribute_name}".to_sym, data: { target: "#{data_controller}.removeImage" })
  end

  # https://github.com/carrierwaveuploader/carrierwave#making-uploads-work-across-form-redisplays
  def image_cache
    @builder.hidden_field("#{attribute_name}_cache".to_sym)
  end
end