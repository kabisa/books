// Minimal expected markup:
//
// <div data-controller="range-slider">
//   <div class="zero-items">...</div>
//   <div class="other-items">
//     <span data-target="range-slider.value">42</span>
//     <a data-action="range-slider#reset" href="#">Clear</a>
//   </div>
//   <input data-target="range-slider.range" data-action="input->range-slider#updateValue" type="range">
// </div>

import {Controller} from 'stimulus';

const ACTIVE_CLASSNAME = 'btn-outline-primary';
const INACTIVE_CLASSNAME = 'btn-outline';
const ZERO_ITEMS_CLASSNAME = 'zero-items';
const OTHER_ITEMS_CLASSNAME = 'other-items';

export default class extends Controller {
  static targets = ['range', 'value', 'label', 'dropdownToggle'];

  connect() {
    this.updateValue();
    this.updateButton();
  }

  initialize() {
    this.initialButtonText = this.dropdownToggleTarget.innerHTML;
  }

  updateValue() {
    this.valueTarget.innerHTML = this.value;

    this.hideAllItemsNodes();

    switch (this.value) {
      case 0:
        this.showZeroItemsNodes();
        break;
      default:
        this.showOtherItemsNodes();
        break;
    }
  }

  reset(event) {
    event.preventDefault();
    this.rangeTarget.value = '0';
    this.updateValue();
  }

  hideAllItemsNodes() {
    this.allItemsNodes.forEach((el) => {
      this.hide(el);
    });
  }

  showZeroItemsNodes() {
    this.zeroItemsNodes.forEach((el) => {
      this.show(el);
    });
  }

  showOtherItemsNodes() {
    this.otherItemsNodes.forEach((el) => {
      this.show(el);
    });
  }

  show(el) {
    el.classList.remove('d-none');
  }

  hide(el) {
    el.classList.add('d-none');
  }

  updateButton() {
    if (this.value !== 0) {
      this.showAsActive();
    } else {
      this.showAsInactive();
    }
  }

  showAsActive() {
    const label = this.labelTarget.innerText;

    this.setButtonText(label);
    this.dropdownToggleTarget.classList.add(ACTIVE_CLASSNAME);
    this.dropdownToggleTarget.classList.remove(INACTIVE_CLASSNAME);
  }

  showAsInactive() {
    this.setButtonText(this.initialButtonText);
    this.dropdownToggleTarget.classList.remove(ACTIVE_CLASSNAME);
    this.dropdownToggleTarget.classList.add(INACTIVE_CLASSNAME);
  }

  setButtonText(value) {
    this.dropdownToggleTarget.innerHTML = value;
  }
  get value() {
    return parseInt(this.rangeTarget.value);
  }

  get zeroItemsNodes() {
    return this.element.querySelectorAll(`.${ZERO_ITEMS_CLASSNAME}`);
  }

  get otherItemsNodes() {
    return this.element.querySelectorAll(`.${OTHER_ITEMS_CLASSNAME}`);
  }

  get allItemsNodes() {
    return this.element.querySelectorAll(
      `.${ZERO_ITEMS_CLASSNAME}, .${OTHER_ITEMS_CLASSNAME}`,
    );
  }
}
