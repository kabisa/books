import _ from "lodash";
import { Controller } from "stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["form", "query"];

  connect() {
    this.moveCursorToEnd(this.queryTarget);
    this.perform = _.debounce(this._perform, 500).bind(this);
  }

  _perform(event) {
    event.preventDefault();
    Rails.fire(this.formTarget, "submit");
  }

  moveCursorToEnd(el) {
    if (typeof el.selectionStart == "number") {
      el.selectionStart = el.selectionEnd = el.value.length;
    } else if (typeof el.createTextRange != "undefined") {
      el.focus();
      const range = el.createTextRange();
      range.collapse(false);
      range.select();
    }
  }
}
