import Comment from '../comment'

$(() => {
  $("[data-form-submit-comment]").on('click', () => {
    const text = document.querySelector("[data-form-text-area-comment]").value
    if (text) {
      const comment = new Comment();
      event.preventDefault();
      comment.send();
    }
  });
})
