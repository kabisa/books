import DropdownController from './dropdown_controller';

const CLASSNAMES = {
  hide: 'd-none',
  border: 'border-primary',
};

export default class extends DropdownController {
  static targets = ['min', 'max', 'label', 'zeroItems', 'otherItems', 'button'];

  connect() {
    super.connect();
    this.initialToggleText = this.toggleTarget.innerHTML;
    this.render();
  }

  render() {
    this.updateLabel();
    this.updateVisibility();
    this.updateButton();
  }

  reset(event) {
    event.preventDefault();
    this.minTarget.value = this.lowerBound;
    this.maxTarget.value = this.upperBound;
    this.render();
  }

  updateLabel() {
    if (this.isInactive) {
      return;
    }

    let label;

    if (this.hasMin) {
      if (this.hasMax) {
        label = `${this.minValue} - ${this.maxValue}`;
      } else {
        label = `Min. ${this.minValue}`;
      }
    } else {
      label = `Max. ${this.maxValue}`;
    }

    this.labelTarget.innerHTML = label;
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
    this.buttonTarget.classList.toggle(CLASSNAMES.border, this.isActive);
    if (this.isActive) {
      this.toggleTarget.innerHTML = `${this.initialToggleText}: ${this.labelTarget.innerText}`;
    }
  }

  get lowerBound() {
    return parseInt(this.minTarget.getAttribute('min'));
  }

  get upperBound() {
    return parseInt(this.maxTarget.getAttribute('max'));
  }

  get minValue() {
    return parseInt(this.minTarget.value);
  }

  get maxValue() {
    return parseInt(this.maxTarget.value);
  }

  get hasMin() {
    return this.minValue > this.lowerBound;
  }

  get hasMax() {
    return this.maxValue < this.upperBound;
  }

  get isActive() {
    return this.minValue > 0 || this.maxValue < this.upperBound;
  }

  get isInactive() {
    return !this.isActive;
  }
}
