import {Controller} from 'stimulus';
import Tagify from '@yaireo/tagify';
import $ from 'jquery';

// This controller decorates the element with Tagify
// to turn values in the element into chips.
// See https://yaireo.github.io/tagify/
// By defining a custom `tag` template we can display
// chips as used in http://daemonite.github.io/material/docs/4.1/material/chips/
export default class extends Controller {
  initialize() {
    const tagify = new Tagify(this.element);
  }
}
