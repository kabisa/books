class DatepickerInput < SimpleForm::Inputs::StringInput

  def input(wrapper_options)
    if (max_date = input_html_options.dig(:data, :max_date))
      input_html_options[:data][:max_date] = l(max_date.to_date)
    end

    if (min_date = input_html_options.dig(:data, :min_date))
      input_html_options[:data][:min_date] = l(min_date.to_date)
    end

    input_html_options.deep_merge!({
      data: {
        format: I18n.t('date.formats.js.default'),
        controller: data_controller
      }
    })

    super
  end

  private
  def data_controller
    'datepicker'
  end

end
