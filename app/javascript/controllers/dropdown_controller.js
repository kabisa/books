import {Controller} from 'stimulus';

export default class extends Controller {
  connect() {
    this.element.querySelectorAll('.dropdown-menu').forEach((el) => {
      el.addEventListener('click', (event) => {
        event.stopPropagation();
      });
    });
  }

  preventClose(event) {
    this.preventClose(event);
  }

  updatePosition() {
    let toggle = this.element.getElementsByClassName('dropdown-toggle')[0];
    $(toggle).dropdown('update');
  }

  close() {
    let toggle = this.element.getElementsByClassName('dropdown-toggle')[0];
    $(toggle).dropdown('hide');
  }
}
