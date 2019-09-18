import {Controller} from 'stimulus';

export default class extends Controller {
  static targets = ['container'];

  connect() {
    this.show();
    setTimeout(() => {
      this.hide();
    }, 6000);
  }

  show() {
    setTimeout(() => {
      this.snackbar.classList.add('show');
    }, 0);
  }

  hide() {
    this.snackbar.addEventListener('transitionend', () => {
      this.snackbar.remove();
    });
    this.snackbar.classList.remove('show');
  }

  get snackbar() {
    return this.containerTarget;
  }
}
