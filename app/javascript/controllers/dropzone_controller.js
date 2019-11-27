import {Controller} from 'stimulus';

export default class extends Controller {
  static targets = ['fileInput', 'previewImage', 'removeButton', 'removeImage'];
  connect() {
    if (this.previewImageTarget.src === '') {
      this.removeButtonTarget.style.display = 'none';
    }
  }

  handleImage(e) {
    let droppedFile = e.target.files[0];
    let accepted = this.fileInputTarget.accept;

    if (droppedFile.type.match(accepted)) {
      let reader = new FileReader();
      reader.onload = (event) => {
        this.previewImageTarget.setAttribute('src', event.target.result);
      };
      reader.readAsDataURL(e.target.files[0]);
      this.removeImageTarget.value = false;
      this.removeButtonTarget.style.display = 'block';
    }
  }

  browse(e) {
    e.preventDefault();
    this.fileInputTarget.click();
  }

  removeImage(e) {
    e.preventDefault();

    this.fileInputTarget.value = '';
    this.removeImageTarget.value = true;
    this.previewImageTarget.removeAttribute('src');
    this.removeButtonTarget.style.display = 'none';
  }
}
