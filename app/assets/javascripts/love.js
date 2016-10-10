document.addEventListener("turbolinks:load", () => {
  let elem = document.querySelector("[data-form-submit-comment]");
  elem.addEventListener('click', (event) => {
    event.preventDefault();
    let comments = document.querySelector("[data-comments]")
    let target_id  = comments.childElementCount
    let body = document.querySelector("[data-form-text-area-comment]").value;
    let commentable_id = document.getElementById('comment_commentable_id').value
    let commentable_type = document.getElementById('comment_commentable_type').value
    let member_id = document.getElementById('comment_member_id').value
    $.ajax({
      url: "/comments",
      type: "POST",
      data: { comment: { body: body,
                         commentable_id: commentable_id,
                         commentable_type: commentable_type,
                         member_id: member_id } },
      success: (data) => {
        $(`[data-comment-no=${target_id}]`).after(data)
      }
    });
  });
});
