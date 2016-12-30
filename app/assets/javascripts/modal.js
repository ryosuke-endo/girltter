export default class {
  constructor(fadeout, time = 3000) {
    this.time = time;
    this.fadeout = fadeout
  }

  open(){
    this.centaring();
    $("#c-modal__content").fadeIn("slow");
    if (this.fadeout === true) {
      setTimeout(() => {
          $("#c-modal__content").fadeOut("slow");
          },this.time);
    }
  }

  centaring() {
    const $w = $(window).width();
    const $h = $(window).height();
    const $cw = $("#c-modal__content").outerWidth();
    const $ch = $("#c-modal__content").outerHeight();
    $("#c-modal__content").css({"left": (($w - $cw)/2) + "px","top": (($h - $ch)/2)+ "px"});
  }
}
