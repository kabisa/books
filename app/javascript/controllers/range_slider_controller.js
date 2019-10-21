import {Controller} from 'stimulus';

export default class extends Controller {
  static targets = ['range', 'value'];

  connect() {
    this.updateValue();
  }

  updateValue() {
    this.valueTarget.innerHTML = this.value;

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
    this.hideOtherLikesNodes();
    this.hideZeroLikesNodes();
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
    el.style.display = 'block';
  }

  hide(el) {
    el.style.display = 'none';
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
