## Introduction

[Daemonite's Material UI](https://daemonite.github.io/material/docs/4.1/material/pickers/#date-pickers) is great for giving your [Bootstrap](https://getbootstrap.com/) page a [Material](https://material.io/) look-and-feel. However, the [Datepicker](https://daemonite.github.io/material/docs/4.1/material/pickers/#date-pickers) for v4.1.1 doesn't work well.

[Gijgo](https://gijgo.com) gives you a set of JS controls that includes a [Datepicker](https://gijgo.com/datepicker) that is styled according to the Material specs (at least, it comes close imho).

This document describes what setup and configuration is needed to use this Datepicker in your Rails project.

## Prerequisites

* Bootstrap 4
* Daemonite's Material UI
* SimpleForm

[This gist](https://gist.github.com/bazzel/a03bfc72dbd8966b0bedb74e164ddce0) describes you to setup these prerequisites.

## Gijgo

Gijgo is a set of JS controls that contains the Datepicker (both JS and CSS) (amongst other controls, which are not mentioned in this document).

* First add the Gijgo library:

        $ yarn add gijgo

* For Gijgo to work, we need jQuery to be exposed as a global. We also need to [rewrite relative paths](https://github.com/rails/webpacker/blob/master/docs/css.md#resolve-url-loader) to avoid errors when Gijgo tries to load fonts:

        $ yarn add expose-loader resolve-url-loader

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