document.addEventListener("turbolinks:load", () => {
  class Comment {
    constructor(comments) {
      this.target_id = comments.childElementCount;
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
                           member_id: this.member_id } },
        success: (data) => {
          $(`[data-comment-no=${this.target_id}]`).after(data);
        }
      });
    }

  }
  function commentForm() {
    return document.querySelector("[data-form-submit-comment]");
  }

  function getComments() {
    return document.querySelector("[data-comments]");
  }

  commentForm().addEventListener('click', (event) => {
    event.preventDefault();
    comment = new Comment(getComments());
    comment.send();
  })
});
