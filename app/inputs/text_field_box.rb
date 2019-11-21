# Include this module in a SimpleForm input class
# to present the input element as a text field box
# Text field boxes increase text field identifiability
# and scannability by using a transparent rectangular
# fill to enclose the label and input text.
#
# @see http://daemonite.github.io/material/docs/4.1/material/text-fields/#text-field-boxes
module TextFieldBox
  def input(wrapper_options)
    ensure_placeholder
    decorate_w_required
    swap_hint_w_error

    super
  end

  private
  def decorate_w_required
    if @required
      append_required_mark
      prepend_required_text
    end
  end

  def ensure_placeholder
    input_html_options[:placeholder] ||= raw_label_text
  end

  def append_required_mark
    input_html_options[:placeholder].concat(self.class.translate_required_mark)
  end

  def prepend_required_text
    @hint = ["#{self.class.translate_required_mark} #{self.class.translate_required_text.titleize}", hint].compact.join(' - ')
  end

  # see https://material.io/components/text-fields/#anatomy
  def swap_hint_w_error
    if object.errors[attribute_name].any?
      input_options[:hint] = false
    end
  end

end
