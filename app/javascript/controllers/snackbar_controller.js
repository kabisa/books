import {Controller} from 'stimulus';

export default class extends Controller {
  static targets = ['container'];

  connect() {
    this._hidePreviousSnackbars();
    this._show();
    setTimeout(() => {
      this.hide();
    }, 6000);
  }

  // Actions:
  //
  hide() {
    this._hideAndRemove(this.snackbar);
  }
  // END Actions

  get snackbar() {
    return this.containerTarget;
  }

  // Private:
  //
  _hidePreviousSnackbars() {
    let els = document.getElementsByClassName('snackbar show');

    Array.from(els).forEach((el) => {
      this._hideAndRemove(el);
    });
  }

  _show() {
    setTimeout(() => {
      this.snackbar.classList.add('show');
    }, 0);
  }

  _hideAndRemove(el) {
    el.addEventListener('transitionend', () => {
      el.remove();
    });
    el.classList.remove('show');
  }
}
