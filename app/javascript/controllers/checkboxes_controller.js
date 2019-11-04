// Minimal expected markup:
//

// Currently this controller has no unit test.
// To get inspired, see https://shime.sh/testing-stimulus
import {Controller} from 'stimulus';

const ACTIVE_CLASSNAME = 'btn-outline-primary';
const INACTIVE_CLASSNAME = 'btn-outline';

export default class extends Controller {
  static targets = ['selectAll', 'value', 'dropdownToggle'];

  initialize() {
    this.initialButtonText = this.dropdownToggleTarget.innerHTML;
    this.updateSwitch();
    this.updateButton();
  }

  toggle() {
    this.valueTargets.forEach((e) => {
      e.checked = this.selectAllTarget.checked;
    });
  }

  updateSwitch() {
    this.selectAllTarget.checked = this.valueTargets.every((e) => e.checked);
  }

  updateButton() {
    if (this.valueTargets.some((e) => e.checked)) {
      this.showAsActive();
    } else {
      this.showAsInactive();
    }
  }

  showAsActive() {
    const ids = this.valueTargets.filter((e) => e.checked).map((e) => e.value);
    const firstId = ids[0];
    let label = this.element.querySelector(
      `label[for="q_tags_id_in_${firstId}"]`,
    ).innerText;

    if (ids.length > 1) {
      label = `${label} +${ids.length - 1}`;
    }

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
}
