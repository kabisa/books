import DropdownController from './dropdown_controller';

const CLASSNAMES = {
  hide: 'd-none',
  border: 'border-primary',
};
export default class extends DropdownController {
  static targets = ['selectAll', 'value', 'zeroItems', 'otherItems', 'button'];

  connect() {
    super.connect();
    this.render();
  }

  render() {
    this.updateSwitch();
    this.updateVisibility();
    this.updateButton();
  }

  reset(event) {
    event.preventDefault();
    this.valueTargets.forEach((e) => {
      e.checked = false;
    });
    this.render();
  }

  toggle() {
    this.valueTargets.forEach((e) => {
      e.checked = this.selectAllTarget.checked;
    });
    this.render();
  }

  updateSwitch() {
    this.selectAllTarget.checked = this.haveAllSelected;
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
    const ids = this.valueTargets.filter((e) => e.checked).map((e) => e.value);

    if (ids.length > 0) {
      const firstId = ids[0];
      let label = this.element.querySelector(
        `label[for="q_tags_id_in_${firstId}"]`,
      ).innerText;

      if (ids.length > 1) {
        label = `${label} +${ids.length - 1}`;
      }

      this.toggleTarget.innerHTML = label;
    }
    this.buttonTarget.classList.toggle(CLASSNAMES.border, this.isActive);
  }

  get isActive() {
    return this.haveSomeSelected;
  }

  get isInactive() {
    return !this.isActive;
  }

  get haveAllSelected() {
    return this.valueTargets.every((e) => e.checked);
  }

  get haveSomeSelected() {
    return this.valueTargets.some((e) => e.checked);
  }
}
