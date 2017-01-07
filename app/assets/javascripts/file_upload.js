const CONTENT_TYPE = [
  'image/jpg',
  'image/jpeg',
  'image/png',
  'image/gif',
  'image/bmp',
]

export default class {
  constructor() {
    this.reader = new FileReader();
  }

  isContent(type, file) {
    return type.indexOf(file.type) !== -1
  }

  previewImage($image, file) {
    this.reader.readAsDataURL(file);

    this.reader.onload = (file) => {
      $image.replaceWith($('<img>').attr({
        src: file.target.result,
        title: file.name,
        'data-form-image': true
      }));
    }
  }

  upload(e) {
    const file = e.target.files[0];
    const $image = $(`[data-form-image]`);

    if(this.isContent(CONTENT_TYPE, file)) {
      this.previewImage($image, file);
    }
  }
}
