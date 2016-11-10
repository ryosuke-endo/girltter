export default class {
  open(){
    this.centaring();
    $("#c-modal__content").fadeIn("slow");
    setTimeout(() => {
        $("#c-modal__content").fadeOut("slow");
        },3000);
  }

  centaring() {
    let w = $(window).width();
    let h = $(window).height();
    let cw = $("#c-modal__content").outerWidth();
    let ch = $("#c-modal__content").outerHeight();
    $("#c-modal__content").css({"left": ((w - cw)/2) + "px","top": ((h - ch)/2)+ "px"});
  }
}
