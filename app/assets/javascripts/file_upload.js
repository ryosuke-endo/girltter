class FileUpload {
  constructor() {
    $('[data-form-file]').on('change', 'input[type="file"]', (e) => {
      const content_type = ['image/jpg',
                            'image/jpeg',
                            'image/png',
                            'image/gif',
                            'image/bmp']
      this.file = e.target.files[0];
      this.reader = new FileReader();
      this.image = $(`[data-form-topic-image]`);

      if(this.isContent(content_type, this.file)) {
        this.previewImage(this.file);
      }
    });
  }

  isContent(type, file) {
    return type.indexOf(file.type) !== -1
  }

  previewImage(file) {
    this.reader.readAsDataURL(file);

    this.reader.onload = (file) => {
      this.image.replaceWith($('<img>').attr({
        src: file.target.result,
        title: file.name,
        'data-form-topic-image': true
      }));
    }
  }
}

new FileUpload;
