$(() => {
  $('.c-form__file').on('change', 'input[type="file"]', (e) => {
    const content_type = ['image/jpg',
                          'image/jpeg',
                          'image/png',
                          'image/gif']
    const file = e.target.files[0];
    const reader = new FileReader();
    const $image = $(`[data-form-topic-image]`)

    if(content_type.indexOf(file.type) === -1) {
      return false;
    }

    reader.readAsDataURL(file);

    reader.onload = (file) => {
      $image.replaceWith($('<img>').attr({
        src: file.target.result,
        title: file.name,
        'data-form-topic-image': true
      }));
    }
  });
});
