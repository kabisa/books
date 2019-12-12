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
