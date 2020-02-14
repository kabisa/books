# This class renders a text input element that shows an autocomplete
# list when input is entered.
#
# The input expect a Stimulus controller `autocomplete` that uses
# Autocomplete from https://autocomplete.trevoreyre.com/#/
#
# The attribute passed to the input method must have a corresponding
# <attribute>_title and <attribute>_id attribute.
#
# @example
# <%= f.input :reedition, as: :autocomplete %>o
#
# Given that `reedition` is a belongs_to association then a `reedition_id`
# attribute that is expected by the input is already available.
# Also, the model (or decorator, if used) is expected also to have
# a `reedition_title` attribute or method, see the Book model for a concrete example.
class AutocompleteInput < StringInput
  def initialize(builder, attribute_name, column, input_type, options = {})
    super

    @hidden_attribute_name = "#{attribute_name}_id"
    @attribute_name = "#{attribute_name}_title"
  end

  def input(wrapper_options)
    template.content_tag(:div, { class: 'autocomplete', data: { controller: data_controller }}) do
      template.concat super
      template.concat hidden_field
      template.concat autocomplete_result_list
    end
  end

  private
  def data_controller
    'autocomplete'
  end

  def hidden_field
    @builder.hidden_field @hidden_attribute_name, data: { target: "#{data_controller}.value" }
  end

  def autocomplete_result_list
    template.tag.ul(class: 'autocomplete-result-list')
  end
end
