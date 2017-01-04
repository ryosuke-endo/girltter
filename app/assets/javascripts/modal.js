export default class {
  constructor(target, args = new Map()) {
    this.time = args.get('time') || 3000;
    this.fadeout = args.has('fadeout') ? args.get('fadeout') : true
    this.$target = target;
  }

  open(){
    this.centaring();
    this.addBackground();
    this.scrollFix();
    $(`${this.$target.selector}, #p-topic-modal-bg`).fadeIn("slow");
    if (this.fadeout === true) {
      setTimeout(() => {
          $("#c-modal__content").fadeOut("slow");
          },this.time);
    }
  }

  scrollFix() {
    $('body').addClass('p-topic-modal-is-overflow-hidden')
  }

  addBackground() {
    $("body").append('<div id="p-topic-modal-bg"></div>');
  }

  centaring() {
    const $w = $(window).width();
    const $h = $(window).height();
    const $cw = this.$target.outerWidth();
    const $ch = this.$target.outerHeight();
    this.$target.css({"left": (($w - $cw)/2) + "px","top": (($h - $ch)/2)+ "px"});
  }

  close(){
    $('[data-modal__contents], #p-topic-modal-bg').fadeOut("slow", function(){
      $('#p-topic-modal-bg').remove();
      $('body').removeClass('p-topic-modal-is-overflow-hidden');
    });
  }
}
