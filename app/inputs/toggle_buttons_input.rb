# This Input represents a toggle button collection as described on
# http://daemonite.github.io/material/docs/4.1/material/buttons/#toggle-buttons
# By default it uses the `toggle_buttons` (see  `config/initializers/simple_form_daemonite.rb`)
#
# @example:
#  = f.input :type, as: :toggle_buttons, collection: BookType.types.to_sym
#  = f.association :company, as: :toggle_buttons
#
class ToggleButtonsInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  def input(wrapper_options = nil)
    label_method, value_method = detect_collection_methods

    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    @builder.collection_radio_buttons(attribute_name, collection, value_method, label_method,
                                      input_options, merged_input_options) do |b|
      b.label(class: label_class(b.value)) { b.radio_button + b.text }
    end
  end

  private

    def label_class(value)
      label_class = "btn btn-outline btn-sm"
      label_class << ' active' if object.send(attribute_name) == value

      label_class
    end
end
