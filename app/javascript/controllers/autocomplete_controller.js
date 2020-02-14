import {Controller} from 'stimulus';
import Autocomplete from '@trevoreyre/autocomplete-js';

// This controller turns a text input into a autocomplete text input.
//
// This controller works with specially annotated HTML like:
//
// <div class="autocomplete" data-controller="autocomplete">
//   <input type="text"/>
//   <input data-target="autocomplete.value" type="hidden"/>
//   <ul class="autocomplete-result-list"></ul>
// </div>
//
// The endpoint used by the `search` is expected to understand
// the Ransack search method and should be able to
// search for a `title` field.
// The JSON returned should be an array containing object with a `title` and `description`.
export default class extends Controller {
  static targets = ['value'];

  initialize() {
    new Autocomplete(this.element, {
      search: this.search.bind(this),
      onSubmit: this.onSubmit.bind(this),
      getResultValue: ({title}) => title,
      renderResult: this.renderResult,
    });
  }
  async search(input) {
    // Make `books` a data attribute when we decide
    // to re-use this controller.
    const url = `/books.json?q[title_cont]=${encodeURI(input)}`;
    this.valueTarget.value = '';

    if (input.length < 3) {
      return [];
    }

    const response = await fetch(url);
    return await response.json();
  }
  onSubmit({id}) {
    this.valueTarget.value = id;
  }
  renderResult({title, description}, props) {
    let text = title;

    if (description) {
      text = `${text} - <span class="text-muted">${description}</span>`;
    }

    return `<li ${props}>${text}</li>`;
  }
}
