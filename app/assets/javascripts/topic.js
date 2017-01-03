import Modal from './modal'
import Tab from './topic/modal/tab'
import Form from './topic/modal/form'

const modal = new Modal($("[data=icon-item]"), false)
const tab = new Tab
const form = new Form

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
  tab.addActive();
});

$('[data-modal-submit]').click(() => {
  form.submit();
  if(form.isSuccess()) {
    modal.close();
  }
});

$('[data=modal-input]').keyup(() => {
  $('[data-modal-submit-error]').remove();
});

$('[data-modal-close], #p-topic-modal-bg').click(() => {
  modal.close();
});
