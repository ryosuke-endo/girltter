//=require ../comment.module

import Comment from '../comment.module'

function commentSubmit() {
  return document.querySelector("[data-form-submit-comment]");
}

commentSubmit().addEventListener('click', (event) => {
  let text = document.querySelector("[data-form-text-area-comment]").value
  if (text) {
    comment = new Comment();
    event.preventDefault();
    comment.send();
  }
});
