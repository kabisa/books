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
    'cropX',
    'cropY',
    'cropW',
    'cropH',
  ];

  initialize() {
    if (this.canCrop) {
      let opts = {
        viewport: {
          width: 300,
          height: 300,
          type: 'circle',
        },
        boundary: {
          width: 400,
          height: 400,
        },
      };
      this.cropper = new Croppie(this.cropperTarget, opts);
    }
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
    let rawImg;

    if (droppedFile.type.match(accepted)) {
      let reader = new FileReader();
      reader.onload = (e) => {
        rawImg = e.target.result;
        if (this.canCrop) {
          $(this.modalTarget).on('shown.bs.modal', () => {
            cropper.bind({
              url: rawImg,
            });
          });

          $(this.modalTarget).modal('show');
        }
        this.previewImageTarget.setAttribute('src', rawImg);
      };
      reader.readAsDataURL(droppedFile);
      this.removeImageTarget.value = false;
      this.removeButtonTarget.style.display = 'block';
    }
  }

  async crop() {
    const result = await this.cropper.result({type: 'canvas', circle: false});
    const [
      topLeftX,
      topLeftY,
      bottomRightX,
      bottomRightY,
    ] = this.cropper.get().points;

    this.previewImageTarget.setAttribute('src', result);
    this.cropXTarget.value = topLeftX;
    this.cropYTarget.value = topLeftY;
    this.cropWTarget.value = bottomRightX - topLeftX;
    this.cropHTarget.value = bottomRightY - topLeftY;
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

  get canCrop() {
    return this.hasCropperTarget;
  }
}
