import {Controller} from 'stimulus';

export default class extends Controller {
  static targets = ['type'];

  initialize() {
    this.typeTargets.forEach((el, i) => {
      if (el.checked) {
        this.showTypeProperties(el.value);
      }
    });
  }

  toggleTypeProperties() {
    const currentType = event.target.querySelector('input').value;

    this.showTypeProperties(currentType);
  }

  showTypeProperties(currentType) {
    this.element.querySelectorAll('[data-book-type]').forEach((el) => {
      const value = el.dataset.bookType === currentType ? 'block' : 'none';
      el.style.display = value;
    });
  }
}
