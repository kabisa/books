import {Controller} from 'stimulus';

export default class extends Controller {
  static targets = ['fileInput', 'previewImage'];
  connect() {}

  handleImage(e) {
    let reader = new FileReader();
    reader.onload = (event) => {
      this.previewImageTarget.setAttribute('src', event.target.result);
    };
    reader.readAsDataURL(e.target.files[0]);
  }
}
