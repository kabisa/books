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
    this.minTarget.value = this.numOfPagesLower;
    this.maxTarget.value = this.numOfPagesUpper;
    this.render();
  }

  updateLabel() {
    if (this.isInactive) {
      return;
    }

    let label;

    if (this.isMinSet && !this.isMaxSet) {
      label = `Min. ${this.minValue}`;
    }

    if (!this.isMinSet && this.isMaxSet) {
      label = `Max. ${this.maxValue}`;
    }

    if (this.isMinSet && this.isMaxSet) {
      label = `${this.minValue} - ${this.maxValue}`;
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

  get minValue() {
    return parseInt(this.minTarget.value);
  }

  get maxValue() {
    return parseInt(this.maxTarget.value);
  }

  get isMinSet() {
    return this.minValue > this.numOfPagesLower;
  }

  get isMaxSet() {
    return this.maxValue < this.numOfPagesUpper;
  }

  get isActive() {
    return this.minValue > 0 || this.maxValue < this.numOfPagesUpper;
  }

  get numOfPagesLower() {
    return parseInt(this.minTarget.getAttribute('min'));
  }

  get numOfPagesUpper() {
    return parseInt(this.maxTarget.getAttribute('max'));
  }

  get isInactive() {
    return !this.isActive;
  }
}
