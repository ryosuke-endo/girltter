import Modal from './topic/modal/modal'
import Tab from './topic/modal/tab'
import Form from './topic/modal/form'
import FileUpload from './file_upload'

const $target = $('[data-modal__contents]');
const params = new Map().set('fadeout', false)
const modal = new Modal($target, params);

const tab = new Tab;
const form = new Form;
const file_upload = new FileUpload;

$("[data=icon-item]")
  .mouseenter(function() {
    const $this = $(this);
    $this.find("[data=icon-description]").show();
  })
  .mouseleave(function(){
    const $this = $(this);
    $this.find("[data=icon-description]").hide();
  });

$("[data=icon-item]").click(() => {
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

$('[data-form-file]').on('change', 'input[type="file"]', (e) => {
  file_upload.upload(e);
});
