class DropzoneInput < SimpleForm::Inputs::FileInput
  def input(wrapper_options)
    input_html_options.deep_merge!({
      accept: 'image/*',
      data: {
        "#{data_target}": "fileInput",
        action: "#{data_controller}#handleImage"
      }
    })

    template.tag.div(class: 'dropzone-container img-thumbnail', data: { controller: data_controller }) do
      template.concat input_element
      template.concat crop_elements if crop?
    end
  end

  private
  def data_controller
    'dropzone'
  end

  def data_target
    "#{data_controller}-target"
  end

  def crop?
    input_html_options.dig(:data, :crop)
  end

  def input_element
    template.capture do
      template.concat overlay
      template.concat image
      # `@builder.input` (or `self`) renders a wrapper div we do not need.
      template.concat @builder.input_field(attribute_name, input_html_options)
      template.concat remove_image
      template.concat image_cache
    end
  end

  def crop_elements
    template.capture do
      template.concat crop_modal
      template.concat crop_results
    end
  end

  def crop_modal
    options = {
      title: I18n.t('modals.crop.title'),
      data: {
        "#{data_target}": "modal"
      }
    }

    template.render(Bootstrap::ModalComponent.new(**options)) do |c|
      template.capture do
        template.concat template.tag.img(data: { "#{data_target}": "cropper" })
        template.concat(c.with(:footer) do
          template.content_tag(:button, I18n.t('modals.crop.submit'), class: 'btn btn-primary', data: { action: "#{data_controller}#crop", dismiss: :modal })
        end)
      end
    end
  end

  def crop_results
    template.capture do
      %w[x y w h].each do |attribute|
        template.concat @builder.hidden_field("crop_#{attribute}", data: { "#{data_target}": "crop#{attribute.upcase}" })
      end
    end

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
    template.link_to '#', class: template.sm_rnd_btn_class('dropzone-action ml-3 text-light'), data: { "#{data_target}": "removeButton", action: "dragover->#{data_controller}#acceptDrag drop->#{data_controller}#noop #{data_controller}#removeImage" } do
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
        "#{data_target}": "previewImage"
      }
    }

    if object.send("#{attribute_name}?")
      template.image_tag object.send("#{attribute_name}_url"), options
    else
      template.tag.img(**options)
    end
  end

  def remove_image
    @builder.hidden_field("remove_#{attribute_name}".to_sym, data: { "#{data_target}": "removeImage" })
  end

  # https://github.com/carrierwaveuploader/carrierwave#making-uploads-work-across-form-redisplays
  def image_cache
    @builder.hidden_field("#{attribute_name}_cache".to_sym)
  end
end
