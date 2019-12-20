import {Controller} from 'stimulus';
import $ from 'jquery';

export default class extends Controller {
  connect() {
    this.showModal();
    this.putCursorInFirstInput();
  }

  showModal() {
    $(this.element).modal('show');
  }

  putCursorInFirstInput() {
    $(this.element).on('shown.bs.modal', () => {
      const input = this.firstInput;

      if (input) {
        input.focus();
        input.select();
      }
    });
  }

  get firstInput() {
    return this.element.querySelector('input[type="text"]');
  }
}
