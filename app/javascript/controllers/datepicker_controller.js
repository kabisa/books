// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

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
