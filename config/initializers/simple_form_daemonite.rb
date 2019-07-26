# frozen_string_literal: true

# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # vertical forms
  #
  # Custom wrapper to support floating label text fields
  # See http://daemonite.github.io/material/docs/4.1/material/text-fields/#floating-label-text-fields.
  config.wrappers :vertical_form_w_floating_label, tag: 'div', class: 'form-group floating-label', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label
    b.use :input, class: 'form-control', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :vertical_form_w_floating_label
end
