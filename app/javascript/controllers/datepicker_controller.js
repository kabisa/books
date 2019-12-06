// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import {Controller} from 'stimulus';
import 'gijgo';

export default class extends Controller {
  static targets = ['lorem'];
  connect() {
    $(this.loremTarget).datepicker({
      format: 'd-m-yyyy',
      ishowOtherMonths: true,
      showRightIcon: false,
    });
  }
}
