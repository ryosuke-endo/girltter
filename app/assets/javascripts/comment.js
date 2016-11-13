import Modal from './modal'

export default class {
  constructor() {
    this.body = document.querySelector("[data-form-text-area-comment]").value;
    this.commentable_id = document.getElementById('comment_commentable_id').value;
    this.commentable_type = document.getElementById('comment_commentable_type').value;
    this.member_id = document.getElementById('comment_member_id').value;
  }

  insertComment(data) {
    const comments = document.querySelector("[data-comments]");
    if (comments.childElementCount === 0){
      return $(`[data-comments]`).after(data);
    }else{
      return $(`[data-comments]`).find("li").filter(":last").after(data);
    }
  }

  deleteComment() {
    return document.querySelector("[data-form-text-area-comment]").value = "";
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
      this.insertComment(data);
      this.deleteComment();
      const modal = new Modal()
      modal.open();
    }).fail((data) => {
      console.log("fail");
    });
  }
}
