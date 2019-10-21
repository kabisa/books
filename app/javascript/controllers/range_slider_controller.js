// Minimal expected markup:
//
// <div data-controller="range-slider">
//   <div class="zero-likes">...</div>
//   <div class="other-likes">
//     <span data-target="range-slider.value">42</span>
//     <a data-action="range-slider#reset" href="#">Clear</a>
//   </div>
//   <input data-target="range-slider.range" data-action="input->range-slider#updateValue" type="range">
// </div>

import {Controller} from 'stimulus';

export default class extends Controller {
  static targets = ['range', 'value'];

  connect() {
    this.updateValue();
  }

  updateValue() {
    this.valueTargets.forEach((e) => {
      e.innerHTML = this.value;
    });

    this.hideAllLikesNodes();

    switch (this.value) {
      case 0:
        this.showZeroLikesNodes();
        break;
      default:
        this.showOtherLikeNodes();
        break;
    }
  }

  reset(event) {
    event.preventDefault();
    this.rangeTarget.value = '0';
    this.updateValue();
  }

  hideAllLikesNodes() {
    this.hideZeroLikesNodes();
    this.hideOtherLikesNodes();
  }

  showZeroLikesNodes() {
    this.zeroLikesNodes.forEach((el) => {
      this.show(el);
    });
  }

  showOtherLikeNodes() {
    this.otherLikesNodes.forEach((el) => {
      this.show(el);
    });
  }

  hideZeroLikesNodes() {
    this.zeroLikesNodes.forEach((el) => {
      this.hide(el);
    });
  }

  hideOtherLikesNodes() {
    this.otherLikesNodes.forEach((el) => {
      this.hide(el);
    });
  }

  show(el) {
    //el.style.display = 'block';
    el.classList.remove('d-none');
  }

  hide(el) {
    //el.style.display = 'none';
    el.classList.add('d-none');
  }

  get value() {
    return parseInt(this.rangeTarget.value);
  }

  get zeroLikesNodes() {
    return this.element.querySelectorAll('.zero-likes');
  }

  get otherLikesNodes() {
    return this.element.querySelectorAll('.other-likes');
  }
}
