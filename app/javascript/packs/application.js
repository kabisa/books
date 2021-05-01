// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
import "@hotwired/turbo-rails";
require("@rails/activestorage").start();
require("channels");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import $ from "jquery";
import "bootstrap/dist/js/bootstrap";
import "daemonite-material/js/material";

$(document).on("turbo:load", function () {
  // Bootstrap:
  //
  $(
    ".floating-label .custom-select, .floating-label .form-control"
  ).floatinglabel();

  $("body").tooltip({
    selector: '[data-toggle="tooltip"]',
    container: "body",
  });

  $("body").popover({
    selector: '[data-toggle="popover"]',
    container: "body",
    html: true,
    trigger: "hover",
  });

  // Daemonite:
  //
  $(window).on("scroll", function () {
    if ($(window).scrollTop() > 0) {
      $(".toolbar-waterfall").addClass("waterfall");
    } else {
      $(".toolbar-waterfall").removeClass("waterfall");
    }
  });
});

document.documentElement.addEventListener(
  "turbo:before-fetch-request",
  function () {
    $(".tooltip").tooltip("dispose");
  }
);

import "controllers";
