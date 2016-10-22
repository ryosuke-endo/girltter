class Comment {
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
    }).fail((data) => {
      console.log("fail");
    });
  }

}
function commentSubmit() {
  return document.querySelector("[data-form-submit-comment]");
}

function getComments() {
  return document.querySelector("[data-comments]");
}

function getComment() {
  return document.querySelector("[data-form-text-area-comment]").value;
}

function getTargetID(comments) {
  if (comments.childElementCount === 0){
    return $(`[data-comments]`)
  }else{
    count = comments.childElementCount
    return $(`[data-comment-no=${count}]`)
  }
}

commentSubmit().addEventListener('click', (event) => {
  if (getComment()) {
    comment = new Comment(getComments());
    event.preventDefault();
    comment.send();
  }
});

$(function(){
  $("#modal-open").click(function() {
    centaringModal();
    $("#c-modal__content").fadeIn("slow");
    setTimeout(function(){
      $("#c-modal__content").fadeOut("slow",function(){
        $("#c-modal__content").remove();
      });
    },3000);
  });
});

function centaringModal() {
  let w = $(window).width();
  let h = $(window).height();
  // let cw = $("#c-modal__content").outerWidth({margin:true});
  // let ch = $("#c-modal__content").outerHeight({margin:true});
  let cw = $("#c-modal__content").outerWidth();
  let ch = $("#c-modal__content").outerHeight();
  $("#c-modal__content").css({"left": ((w - cw)/2) + "px","top": ((h - ch)/2)+ "px"});
}
