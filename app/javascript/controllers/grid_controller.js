import { Controller } from "stimulus";

// <turbo-frame />-elements in a CSS grid need to be
// styled with "display: 'contents';" to prevent
// the layout from being mixed up.
// However, a <turbo-tag /> with this styling
// is ignored by Turbo, so fetching data with the "loading='lazy'"
// attribute would become useless.
// This controller fixes that shortcoming by adding the styling
// only after the data have been fetched.
//
// See the list of writers page for an example.
export default class extends Controller {
  static classes = ["contents"];

  adjustLayout() {
    this.element.classList.add(this.contentsClass);
  }
}
