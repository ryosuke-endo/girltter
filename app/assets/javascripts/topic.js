import Modal from './modal'

const modal = new Modal($("[data=icon-item]"), false)

$("[data=icon-item]")
  .mouseenter(function() {
    const $this = $(this);
    $this.find("[data=icon-description]").show();
  })
  .mouseleave(function(){
    const $this = $(this);
    $this.find("[data=icon-description]").hide();
  });

$("[data=icon-item]").click(function() {
  modal.open();
});

$('[data-modal-submit]').click(() => {
  modal.submit();
});

$('[data=modal-input]').keyup(() => {
  $('[data-modal-submit-error]').remove();
});

$('[data-modal-close], #p-topic-modal-bg').click(() => {
  modal.close();
});
