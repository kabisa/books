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

  validate(event) {
    if (event.currentTarget === this.minTarget && this.min >= this.max) {
      this.minTarget.value = this.max - this.step;
      this.render();
    }

    if (event.currentTarget === this.maxTarget && this.max <= this.min) {
      this.maxTarget.value = this.min + this.step;
      this.render();
    }
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
        label = `Published ${this.min} - ${this.max} yr. ago`;
      } else {
        label = `Older than ${this.min} yr.`;
      }
    } else {
      label = `Newer than ${this.max} yr.`;
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
      this.toggleTarget.innerHTML = this.labelTarget.innerText;
    }
  }

  get lowerBound() {
    return parseInt(this.minTarget.getAttribute('min'));
  }

  get upperBound() {
    return parseInt(this.maxTarget.getAttribute('max'));
  }

  get min() {
    return parseInt(this.minTarget.value);
  }

  get max() {
    return parseInt(this.maxTarget.value);
  }

  get step() {
    return parseInt(this.maxTarget.getAttribute('step'));
  }

  get hasMin() {
    return this.min > this.lowerBound;
  }

  get hasMax() {
    return this.max < this.upperBound;
  }

  get isActive() {
    return this.min > this.lowerBound || this.max < this.upperBound;
  }

  get isInactive() {
    return !this.isActive;
  }
}
