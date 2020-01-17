import DropdownController from './dropdown_controller';

const CLASSNAMES = {
  hide: 'd-none',
  border: 'border-primary',
};

export default class extends DropdownController {
  static targets = [
    'range',
    'value',
    'label',
    'zeroItems',
    'otherItems',
    'button',
  ];

  connect() {
    super.connect();
    this.initialToggleText = this.toggleTarget.innerHTML;
    this.render();
  }

  render() {
    this.updateValueLabel();
    this.updateVisibility();
    this.updateButton();
  }

  reset(event) {
    event.preventDefault();
    this.rangeTarget.value = this.lowerBound;
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
    this.toggleTarget.innerHTML = `${this.initialToggleText}: ${this.labelTarget.innerText}`;
    this.buttonTarget.classList.toggle(CLASSNAMES.border, this.isActive);
  }

  get lowerBound() {
    return parseInt(this.rangeTarget.getAttribute('min'));
  }

  get rangeValue() {
    return parseInt(this.rangeTarget.value);
  }

  get isActive() {
    return this.rangeValue > this.lowerBound;
  }

  get isInactive() {
    return !this.isActive;
  }
}
