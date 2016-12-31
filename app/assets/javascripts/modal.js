export default class {
  constructor(object, fadeout, time = 3000) {
    this.tab = $(object)
    this.time = time;
    this.fadeout = fadeout;
    this.target = $('[data-modal__contents]');
    this.addActive()
  }

  addActive() {
    const list = this.tab.attr('class').split(/\s/)
    const check_list = ["fa-link", "fa-twitter"]
    const target = list.filter((item) => {
      if ($.inArray(item, check_list) >= 0) {
        return item;
      }
    });
    switch(target[0]) {
      case "fa-link":
        $('[data-fa-link]').addClass('is-active')
        break;
      case "fa-twitter":
        $('[data-fa-twitter]').addClass('is-active')
        break;
    }
  }

  open(){
    this.addBackground();
    this.centaring();
    this.scrollFix();
    $(`[data-modal__contents], #p-topic-modal-bg`).fadeIn("slow");
    if (this.fadeout === true) {
      setTimeout(() => {
          $("#c-modal__content").fadeOut("slow");
          },this.time);
    }
  }

  close(){
  }

  scrollFix() {
    $('body').css('overflow', 'hidden');
  }

  addBackground() {
    $("body").append('<div id="p-topic-modal-bg"></div>');
  }

  centaring() {
    const $w = $(window).width();
    const $h = $(window).height();
    const $cw = this.target.outerWidth();
    const $ch = this.target.outerHeight();
    this.target.css({"left": (($w - $cw)/2) + "px","top": (($h - $ch)/2)+ "px"});
  }
}
