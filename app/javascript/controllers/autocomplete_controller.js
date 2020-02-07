// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import {Controller} from 'stimulus';
import Autocomplete from '@trevoreyre/autocomplete-js';

export default class extends Controller {
  static targets = ['value'];
  initialize() {
    new Autocomplete(this.element, {
      search: this.search.bind(this),
      onSubmit: this.onSubmit.bind(this),
      getResultValue: this.getResultValue.bind(this),
      renderResult: this.renderResult.bind(this),
    });
  }
  search(input) {
    const url = `/books.json?q[title_cont]=${encodeURI(input)}`;

    return new Promise((resolve) => {
      if (input.length < 3) {
        return resolve([]);
      }

      fetch(url)
        .then((response) => response.json())
        .then((data) => {
          resolve(data);
        });
    });
  }
  onSubmit(result) {
    console.log('onSubmit');
    this.valueTarget.value = result.id;
  }
  getResultValue({title}) {
    return title;
  }
  renderResult(result, props) {
    let text = `<span>${result.title}</span>`;

    if (result.description) {
      text = `${text}  - <span class="text-muted">${result.description}</span>`;
    }
    return `<li ${props}>${text}</li>`;
  }

  reset(e) {
    if (e.target.value === '') {
      this.valueTarget.value = '';
    }
  }
}
