//=require ../comment.module

import Comment from '../comment.module'

$("[data-form-submit-comment]").on('click', function() {
  const text = document.querySelector("[data-form-text-area-comment]").value
  if (text) {
    comment = new Comment();
    event.preventDefault();
    comment.send();
  }
});
