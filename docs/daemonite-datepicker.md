# Using Daemonite Datepicker

## TL;DR

If you want a datepicker for date fields, use:

    <%= f.input :published_on, as: :datepicker, input_html: { data: { max: 6.months.from_now }} %>

## Introduction

[Daemonite's Material UI](https://daemonite.github.io/material/docs/4.1/material/pickers/#date-pickers) is great for giving your [Bootstrap](https://getbootstrap.com/) page a [Material](https://material.io/) look-and-feel. However, the [Datepicker](https://daemonite.github.io/material/docs/4.1/material/pickers/#date-pickers) for v4.1.1 doesn't work well.

However, a [small fix](https://github.com/Daemonite/material/issues/232#issuecomment-558872110) is all it takes to make it work.

This document describes what setup and configuration is needed to use this Datepicker in your Rails project.

## Prerequisites

* Bootstrap 4 ([gist](https://gist.github.com/bazzel/2c64e2e5804077f9a61938a93ed54823))
* Daemonite's Material UI ([gist](https://gist.github.com/bazzel/0226bf815c9018388ae2e7e3bc438c57))
* SimpleForm ([gist](https://gist.github.com/bazzel/a03bfc72dbd8966b0bedb74e164ddce0))

## Datepicker

### Custom input and controller

Next we create a SimpleForm custom input and a [Stimulus](https://stimulusjs.org/) controller for the Datepicker.

> If you have not setup your Rails project with Stimulus, see [this guide](https://github.com/rails/webpacker#stimulus) how to do this.

We want to render a Datepicker field as follows:
  
        <%= f.input :published_on, as: :datepicker %>

We also want to be able to configure the Datepicker dynamically, by passing options as data attributes, e.g.:
        
        <%= f.input :published_on, as: :datepicker, input_html: { data: { max: 6.months.from_now }} %>
        
Although these attributes can be used without writing extra code, we do need to write some code to make it work with the actual Datepicker. For this we take the following approach:
  
* all data-attributes passed to the `input` method are handled as [Datepicker configuration options](https://daemonite.github.io/material/docs/4.1/material/pickers/#options)

  > Make sure you 'underscore' the options when passing them as data-attribute. E.g. use `{ data: {calendar_weeks: true }}`

  > Some configuration options may be ignored, such as `disable`, due to the misinterpretation of the passed datatype. Since I don't need this option at the moment, I didn't spend time on making it work. 

* we use a Stimulus controller that will act as glue between the rendered input element and the datapicker component. We will call this controller `datepicker`.
* the `DatepickerInput` component (which we will write next) add some default configuration options as data-attributes
   * it adds a `data-controller` attribute to link the `datapicker` Stimulus controller with the rendered input element
   * it adds a `data-format` attribute and uses Rails' localization settings to have the Datepicker format the date correctly:
     * dates (such as `min` and `max`) used in data-attributes need to be reformatted in a Gijgo-friendly way, e.g. `data: { max: 6.months.from_now }` should be rendered as `data-max="2020-06-10"` instead of `data-max="2020-06-10T09:01:36.755Z"`.

This will give us the following Stimulus controller:
  
```javascript
// app/javascript/controllers/datepicker_controller.js

import {Controller} from 'stimulus';
import $ from 'jquery';

export default class extends Controller {
  connect() {
    const defaultOptions = {
      closeOnSelect: true,
      ok: '',
      cancel: '',
      selectMonths: true,
      selectYears: true,
    };

    const options = {...defaultOptions, ...this.element.dataset};

    //$(this.element).pickdate(options);
    // Workaround for 'auto close' issue, see https://github.com/Daemonite/material/issues/232
    $(this.element)
      .on('mousedown', function(event) {
        event.preventDefault();
      })
      .pickdate(options);
  }
}
```
  
And a SimpleForm custom input:  

```ruby
# app/inputs/datepicker_input.rb

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
```

If you want a datepicker for date fields, you can now use:

    <%= f.input :published_on, as: :datepicker, input_html: { data: { max: 6.months.from_now }} %>
