import {Controller} from 'stimulus';

const CLASSNAMES = {
  active: 'btn-outline-primary',
  inactive: 'btn-outline',
  hide: 'd-none',
};

export default class extends Controller {
  static targets = [
    'range',
    'value',
    'label',
    'toggle',
    'zeroItems',
    'otherItems',
  ];

  initialize() {
    this.initialButtonText = this.toggleTarget.innerHTML;
  }

  connect() {
    this.render();
  }

  render() {
    this.updateValueLabel();
    this.updateVisibility();
    this.updateButton();
  }

  reset(event) {
    event.preventDefault();
    this.rangeTarget.value = '0';
    this.render();
  }

  updateValueLabel() {
    this.valueTarget.innerHTML = this.rangeValue;
  }

  updateVisibility() {
    this.zeroItemsTargets.forEach((el) => {
      el.classList.toggle(CLASSNAMES.hide, this.isActive);
    });
    this.otherItemsTargets.forEach((el) => {
      el.classList.toggle(CLASSNAMES.hide, this.isInactive);
    });
  }

  updateButton() {
    const buttonText = this.isActive
      ? this.labelTarget.innerText
      : this.initialButtonText;
    this.toggleTarget.innerHTML = buttonText;
    this.toggleTarget.classList.toggle(CLASSNAMES.active, this.isActive);
    this.toggleTarget.classList.toggle(CLASSNAMES.inactive, this.isInactive);
  }

  get rangeValue() {
    return parseInt(this.rangeTarget.value);
  }

  get isActive() {
    return this.rangeValue > 0;
  }

  get isInactive() {
    return !this.isActive;
  }
}
