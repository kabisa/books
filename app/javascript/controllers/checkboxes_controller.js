// Minimal expected markup:
//

// Currently this controller has no unit test.
// To get inspired, see https://shime.sh/testing-stimulus
import {Controller} from 'stimulus';

export default class extends Controller {
  static targets = ['selectAll', 'value', 'buttonText'];

  initialize() {
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
    this.hideAllTagsNodes();

    if (this.valueTargets.some((e) => e.checked)) {
      this.showOtherTagsNodes();
      this.updateButtonText();
    } else {
      this.showZeroTagsNodes();
    }
  }

  updateButtonText() {
    const ids = this.valueTargets.filter((e) => e.checked).map((e) => e.value);
    const firstId = ids[0];
    let label = this.element.querySelector(
      `label[for="q_tags_id_in_${firstId}"]`,
    ).innerText;

    if (ids.length > 1) {
      label = `${label} +${ids.length - 1}`;
    }

    this.buttonTextTarget.innerHTML = label;
  }

  hideAllTagsNodes() {
    this.allTagsNodes.forEach((el) => {
      this.hide(el);
    });
  }

  showZeroTagsNodes() {
    this.zeroTagsNodes.forEach((el) => {
      this.show(el);
    });
  }

  showOtherTagsNodes() {
    this.otherTagsNodes.forEach((el) => {
      this.show(el);
    });
  }

  show(el) {
    el.classList.remove('d-none');
  }

  hide(el) {
    el.classList.add('d-none');
  }

  get value() {
    return parseInt(this.rangeTarget.value);
  }

  get zeroTagsNodes() {
    return this.element.querySelectorAll('.zero-tags');
  }

  get otherTagsNodes() {
    return this.element.querySelectorAll('.other-tags');
  }

  get allTagsNodes() {
    return this.element.querySelectorAll('.zero-tags, .other-tags');
  }
}
