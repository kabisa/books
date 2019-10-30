import {Controller} from 'stimulus';
import Tagify from '@yaireo/tagify/dist/tagify';

// This controller decorates the element with Tagify
// to turn values in the element into chips.
// See https://yaireo.github.io/tagify/
// By defining a custom `tag` template we can display
// chips as used in http://daemonite.github.io/material/docs/4.1/material/chips/
export default class extends Controller {
  initialize() {
    const tagify = new Tagify(this.element, {
      templates: {
        tag(v, tagData) {
          const attrs = this.getAttributes(tagData);
          // `tagify__tag` is needed to animate the chip
          return `<tag class='chip tagify__tag' ${attrs}> ${v}<x class="close material-icons">cancel</x></tag>`;
        },
      },
    });

    // Plugin changes the markup so we manually
    // need to tell the element to float the label correctly
    tagify
      .on('add', () => {
        this.floatLabel();
      })
      .on('remove', () => {
        this.floatLabel();
      });
  }

  floatLabel() {
    $(this.element).floatinglabel();
  }
}
