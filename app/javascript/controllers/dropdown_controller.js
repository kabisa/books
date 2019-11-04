import {Controller} from 'stimulus';

export default class extends Controller {
  connect() {
    this.element.querySelectorAll('.dropdown-menu').forEach((el) => {
      el.addEventListener('click', (event) => {
        event.stopPropagation();
      });
    });
  }

  close() {
    let toggle = this.element.getElementsByClassName('dropdown-toggle')[0];
    $(toggle).dropdown('hide');
  }
}
