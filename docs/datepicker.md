# Using Gijgo Datepicker

## TL;DR

If you want a datepicker for date fields, use:

    <%= f.input :published_on, as: :datepicker, input_html: { data: { max_date: 6.months.from_now }} %>

## Introduction

[Daemonite's Material UI](https://daemonite.github.io/material/docs/4.1/material/pickers/#date-pickers) is great for giving your [Bootstrap](https://getbootstrap.com/) page a [Material](https://material.io/) look-and-feel. However, the [Datepicker](https://daemonite.github.io/material/docs/4.1/material/pickers/#date-pickers) for v4.1.1 doesn't work well.

[Gijgo](https://gijgo.com) gives you a set of JS controls that includes a [Datepicker](https://gijgo.com/datepicker) that is styled according to the Material specs (at least, it comes close imho).

This document describes what setup and configuration is needed to use this Datepicker in your Rails project.

## Prerequisites

* Bootstrap 4 ([gist](https://gist.github.com/bazzel/2c64e2e5804077f9a61938a93ed54823))
* Daemonite's Material UI ([gist](https://gist.github.com/bazzel/0226bf815c9018388ae2e7e3bc438c57))
* SimpleForm ([gist](https://gist.github.com/bazzel/a03bfc72dbd8966b0bedb74e164ddce0))

## Gijgo

Gijgo is a set of JS controls that contains the Datepicker (both JS and CSS) (amongst other controls, which are not mentioned in this document).

### Install and configure node modules

* First add the Gijgo library. For Gijgo to work, we need jQuery to be exposed as a global. We also need to [rewrite relative paths](https://github.com/rails/webpacker/blob/master/docs/css.md#resolve-url-loader) to avoid errors when Gijgo tries to load fonts:

        $ yarn add gijgo expose-loader resolve-url-loader

```javascript
// config/webpack/environment.js

environment.loaders.append('expose', {
  test: require.resolve('jquery'),
  use: [
    {
      loader: 'expose-loader',
      options: 'jQuery',
    },
    {
      loader: 'expose-loader',
      options: '$',
    },
  ],
});

// resolve-url-loader must be used before sass-loader
environment.loaders.get('sass').use.splice(-1, 0, {
  loader: 'resolve-url-loader',
  options: {
    attempts: 1,
  },
});

```

### Load the Gijgo CSS

```scss
// app/javascript/packs/styles.scss

@import '~gijgo/css/gijgo';
```

### Custom input and controller

Next we create a SimpleForm custom input and a [Stimulus](https://stimulusjs.org/) controller for the Datepicker.

> If you have not setup your Rails project with Stimulus, see [this guide](https://github.com/rails/webpacker#stimulus) how to do this.

We want to render a Datepicker field as follows:
  
        <%= f.input :published_on, as: :datepicker %>

We also want to be able to configure the Datepicker dynamically, by passing options as data attributes, e.g.:
        
        <%= f.input :published_on, as: :datepicker, input_html: { data: { max_date: 6.months.from_now }} %>
        
Although these attributes can be used without writing extra code, we do need to write some code to make it work with the actual Datepicker. For this we take the following approach:
  
* all data-attributes passed to the `input` method are handled as [Datepicker configuration options](https://gijgo.com/datepicker/configuration)

  > Make sure you 'underscore' the options when passing them as data-attribute. E.g. use `{ data: {calendar_weeks: true }}`

  > Some configuration options will be ignored, such as `disable_days_of_week`, due to the misinterpretation of the passed datatype. Since I don't need this option at the moment, I didn't spend time on making it work. 

* we use a Stimulus controller that will act as glue between the rendered input element and the datapicker component. We will call this controller `datepicker`.
* the `DatepickerInput` component (which we will write next) add some default configuration options as data-attributes
   * it adds a `data-controller` attribute to link the `datapicker` Stimulus controller with the rendered input element
   * it adds a `data-format` attribute and uses Rails' localization settings to have the Datepicker format the date correctly:
     * dates (such as `min_date` and `max_date`) used in data-attributes need to be reformatted in a Gijgo-friendly way, e.g. `data: { max_date: 6.months.from_now }` should be rendered as `data-max-date="2020-06-10"` instead of `data-max-date="2020-06-10T09:01:36.755Z"`.

This will give us the following Stimulus controller:
  
```javascript
// app/javascript/controllers/datepicker_controller.js

import {Controller} from 'stimulus';
import $ from 'jquery';
import 'gijgo';

export default class extends Controller {
  connect() {
    const defaultOptions = {
      ishowOtherMonths: true,
      showOtherMonths: true,
      showRightIcon: false,
    };

    const options = {...defaultOptions, ...this.element.dataset};

    $(this.element).datepicker(options);
  }
}
```
  
And SimpleForm custom input:  

```ruby
# app/inputs/datepicker_input.rb

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
```