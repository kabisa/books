# frozen_string_literal: true

Dir[Rails.root.join('lib/components/**/*.rb')].each { |f| require f }

# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # vertical forms
  #
  # Custom wrapper to support floating label text fields
  # See http://daemonite.github.io/material/docs/4.1/material/text-fields/#floating-label-text-fields.
  config.wrappers :vertical_form_w_floating_label, tag: 'div', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.wrapper tag: :div, class: 'floating-label' do |c|
      c.use :label
      c.use :input, class: 'form-control', error_class: 'is-invalid', valid_class: 'is-valid'
      c.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
      c.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  # Custom wrapper to support text field boxes
  # See http://daemonite.github.io/material/docs/4.1/material/text-fields/#text-field-boxes
  config.wrappers :vertical_form_w_text_field_boxes, tag: 'div', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.wrapper tag: :div, class: 'textfield-box' do |c|
      c.optional :label
      c.use :input, class: 'form-control', error_class: 'is-invalid', valid_class: false
      c.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
      c.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  # Custom wrapper to support text field boxes
  # See https://daemonite.github.io/material/docs/4.1/material/text-fields/#with-floating-labels
  config.wrappers :vertical_form_w_text_field_boxes_w_floating_label, tag: 'div', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.wrapper tag: :div, class: 'floating-label textfield-box' do |c|
      c.use :label
      c.use :input, class: 'form-control', error_class: 'is-invalid', valid_class: false
      c.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
      c.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  config.wrappers :inline_form_w_text_field_boxes, tag: 'span', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.wrapper tag: :div, class: 'textfield-box' do |c|
      c.use :label, class: 'sr-only'

      c.use :input, class: 'form-control', error_class: 'is-invalid', valid_class: 'is-valid'
      c.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
      c.optional :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  # This is a copy of the `custom_file` wrapper but *without* the label.
  # @see http://daemonite.github.io/material/docs/4.1/components/forms/#file-browser
  config.wrappers :my_custom_file, tag: 'div', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.wrapper :custom_file_wrapper, tag: 'div', class: 'custom-file' do |ba|
      ba.use :input, class: 'custom-file-input', error_class: 'is-invalid', valid_class: 'is-valid'
      ba.use :label, class: 'custom-file-label'
      ba.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    end
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # @see http://daemonite.github.io/material/docs/4.1/material/selection-controls/#switches
  config.wrappers :switch, tag: 'div', class: 'form-group custom-control custom-switch' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper tag: 'span', class: 'custom-control-track' do; end
    b.use :input, class: 'custom-control-input', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :label, class: 'custom-control-label'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # Input Group - custom component
  # see example app and config at https://github.com/rafaelfranca/simple_form-bootstrap
  config.wrappers :input_group, tag: 'div', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.wrapper :input_group_tag, tag: 'div', class: 'input-group floating-label textfield-box' do |c|
      c.optional :prepend
      c.use :label
      c.use :input, class: 'form-control', error_class: 'is-invalid', valid_class: false
      c.optional :append
      c.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
      c.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  config.wrappers :toggle_buttons, tag: :div, class: 'btn-group form-group', item_wrapper_tag: false, html: { data: { toggle: 'buttons'}, role: 'group' } do |b|
    b.use :html5
    b.optional :readonly
    b.use :input
  end

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :vertical_form_w_text_field_boxes_w_floating_label

  config.wrapper_mappings = {
    boolean:        :switch,
    date:           :custom_multi_select,
    file:           :my_custom_file,
    toggle_buttons: :toggle_buttons
  }
end
