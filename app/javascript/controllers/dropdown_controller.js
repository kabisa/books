import {Controller} from 'stimulus';
import $ from 'jquery';

export default class extends Controller {
  static targets = ['toggle'];
  close() {
    this.$toggle.dropdown('hide');
  }

  keepOpen(event) {
    event.stopPropagation();
  }

  get $toggle() {
    return $(this.toggleTarget);
  }

  reset() {
    alert(
      `Override the method \`reset\` in the \`${this.identifier}\` controller.`,
    );
  }
}
