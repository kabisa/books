class StringInput < SimpleForm::Inputs::StringInput

  # This is a fix for the floating label text fields
  # as described on http://daemonite.github.io/material/docs/4.1/material/text-fields/#floating-label-text-fields
  # (although I'm not sure if it is a bug...)
  # When a input field with a value is rendered
  # the wrapper div needs to have a class named 'has-value'
  # to position the label correctly. However there's no
  # classname assigned and this only works when an empty input field
  # is given a value.
  def input_class
    if object.send("#{attribute_name}").present?
      super + ' has-value'
    else
      super
    end
  end
end
