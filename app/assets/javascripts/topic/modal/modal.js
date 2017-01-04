import Modal from '../../modal'

export default class extends Modal {

  open() {
    this.addBackground();
    this.scrollFix();
    this.centaring();
    $(`${this.$target.selector}, #p-topic-modal-bg`).fadeIn("slow");
  }

  addBackground() {
    $("body").append('<div id="p-topic-modal-bg"></div>');
  }

  scrollFix() {
    $('body').addClass('p-topic-modal-is-overflow-hidden')
  }

  close(){
    $('[data-modal__contents], #p-topic-modal-bg').fadeOut("slow", () => {
      $('#p-topic-modal-bg').remove();
      $('body').removeClass('p-topic-modal-is-overflow-hidden');
    });
  }
}
