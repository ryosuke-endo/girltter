//=require ../comment.module

import Comment from '../comment.module'

function commentSubmit() {
  return document.querySelector("[data-form-submit-comment]");
}

function getComments() {
  return document.querySelector("[data-comments]");
}

function getComment() {
  return document.querySelector("[data-form-text-area-comment]").value;
}

function deleteComment() {
  return document.querySelector("[data-form-text-area-comment]").value = "";
}

function getTargetID(comments) {
  if (comments.childElementCount === 0){
    return $(`[data-comments]`)
  }else{
    return $(`[data-comments]`).find("li").filter(":last")
  }
}

commentSubmit().addEventListener('click', (event) => {
  if (getComment()) {
    comment = new Comment(getComments());
    event.preventDefault();
    comment.send();
  }
});
