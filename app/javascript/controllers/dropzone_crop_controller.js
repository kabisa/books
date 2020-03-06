import {Controller} from 'stimulus';
import * as Croppie from 'croppie/croppie';

export default class extends Controller {
  static targets = [
    'fileInput',
    'previewImage',
    'removeButton',
    'removeImage',
    'modal',
    'cropper',
  ];
  initialize() {
    let opts = {
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
    this.cropper = new Croppie(this.cropperTarget, opts);
  }
  connect() {
    if (this.previewImageTarget.src === '') {
      this.removeButtonTarget.style.display = 'none';
    }
  }

  handleImage(e) {
    let droppedFile = e.target.files[0];
    let accepted = this.fileInputTarget.accept;
    let cropper = this.cropper;

    if (droppedFile.type.match(accepted)) {
      let reader = new FileReader();
      reader.onload = (event) => {
        this.previewImageTarget.setAttribute('src', event.target.result);
        $(this.modalTarget).on('shown.bs.modal', () => {
          cropper.bind({
            url: event.target.result,
          });
        });

        $(this.modalTarget).modal('show');
      };
      reader.readAsDataURL(e.target.files[0]);
      this.removeImageTarget.value = false;
      this.removeButtonTarget.style.display = 'block';
    }
  }

  crop() {
    let previewImageTarget = this.previewImageTarget;

    this.cropper.result({type: 'canvas', circle: false}).then((result) => {
      previewImageTarget.setAttribute('src', result);
    });
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

  acceptDrag(e) {
    e.preventDefault();
  }

  noop(e) {
    e.preventDefault();
  }
}
