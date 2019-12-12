# This class renders a input element for showing a Daemonite datepicker
# see https://daemonite.github.io/material/docs/4.1/material/pickers
#
# The input expect a Stimulus controller `datepicker` which invokes
# the `pickdate` method provided with
# configuration options.
#
# See docs/datepicker.md for a guide on how to set up a project.
#
# @example
# <%= f.input :published_on, as: :datepicker, input_html: { data: { max: 6.months.from_now }} %>
# You can pass several config options as data attributes.
# See https://daemonite.github.io/material/docs/4.1/material/pickers/#options for this.
class DatepickerInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options)
    transform_to_js_format(:max)
    transform_to_js_format(:min)

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

  def transform_to_js_format(date)
    if (val = input_html_options.dig(:data, date))
      input_html_options[:data][date] = localized(val)
    end
  end

  def localized(val)
    l(val.to_date)
  end
end
