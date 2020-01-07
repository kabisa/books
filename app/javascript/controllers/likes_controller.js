import DropdownController from './dropdown_controller';

const CLASSNAMES = {
  hide: 'd-none',
};

export default class extends DropdownController {
  static targets = ['range', 'value', 'label', 'zeroItems', 'otherItems'];

  connect() {
    super.connect();
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
    this.toggleTarget.innerHTML = this.labelTarget.innerText;
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
