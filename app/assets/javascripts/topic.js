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
  form.cleanText();
  tab.addActive();
});

$('[data-modal-submit]').click(() => {
  form.urlSubmit();
  if(form.isSubmitSuccess()) {
    modal.close();
  }
});

$('[data=modal-input]').keyup(() => {
  form.removeDisplayError();
});

$('[data-modal-close], #p-topic-modal-bg').click(() => {
  modal.close();
});
