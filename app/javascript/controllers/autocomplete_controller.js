import {Controller} from 'stimulus';
import Autocomplete from '@trevoreyre/autocomplete-js';

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
