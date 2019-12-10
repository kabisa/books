# This class renders a input element for showing a Gijgo datepicker
# see https://gijgo.com/datepicker
#
# The input expect the Gijgo library to be installed
# and a Stimulus controller `datepicker` which invokes
# the Gijgo `dateicker` method provided with
# configuration options.
#
# See docs/datepicker.md for a guide on how to set up a project.
#
# @example
# <%= f.input :published_on, as: :datepicker, input_html: { data: { max_date: 6.months.from_now }} %>
# You can pass several config options as data attributes.
# See https://gijgo.com/datepicker/configuration for this.
# Make sure you underscore
class DatepickerInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options)
    transform_to_js_format(:max_date)
    transform_to_js_format(:min_date)

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
