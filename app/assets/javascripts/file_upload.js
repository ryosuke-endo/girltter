export default class {
  constructor() {
    this.reader = new FileReader();
  }

  isContent(type, file) {
    return type.indexOf(file.type) !== -1
  }

  previewImage(image, file) {
    this.reader.readAsDataURL(file);

    this.reader.onload = (file) => {
      image.replaceWith($('<img>').attr({
        src: file.target.result,
        title: file.name,
        'data-form-topic-image': true
      }));
    }
  }

  upload(e) {
    const content_type = ['image/jpg',
      'image/jpeg',
      'image/png',
      'image/gif',
      'image/bmp']
    const file = e.target.files[0];
    const image = $(`[data-form-topic-image]`);

    if(this.isContent(content_type, file)) {
      this.previewImage(image, file);
    }
  }
}
