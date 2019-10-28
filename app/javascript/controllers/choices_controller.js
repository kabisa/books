import {Controller} from 'stimulus';
import Tagify from '@yaireo/tagify/dist/tagify';

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
