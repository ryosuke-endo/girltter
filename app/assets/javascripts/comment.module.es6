//=require modal.module

import Modal from 'modal.module'

export default class {
  constructor(comments) {
    this.target_id = getTargetID(comments)
    this.body = document.querySelector("[data-form-text-area-comment]").value;
    this.commentable_id = document.getElementById('comment_commentable_id').value;
    this.commentable_type = document.getElementById('comment_commentable_type').value;
    this.member_id = document.getElementById('comment_member_id').value;
  }

  send() {
    $.ajax({
      url: "/comments",
      type: "POST",
      data: { comment: { body: this.body,
                         commentable_id: this.commentable_id,
                         commentable_type: this.commentable_type,
                         member_id: this.member_id } }
    }).done((data) => {
      this.target_id.after(data);
      deleteComment();
      modal = new Modal()
      modal.open();
    }).fail((data) => {
      console.log("fail");
    });
  }
}
