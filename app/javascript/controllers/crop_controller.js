import {Controller} from 'stimulus';
import * as Croppie from 'croppie/croppie';

export default class extends Controller {
  initialize() {
    let opts = {
      enableExif: true,
      viewport: {
        width: 200,
        height: 200,
        type: 'circle',
      },
      boundary: {
        width: 300,
        height: 300,
      },
    };
    let img = this.element.getElementsByTagName('img')[0];
    let c = new Croppie(img, opts);
  }
}
