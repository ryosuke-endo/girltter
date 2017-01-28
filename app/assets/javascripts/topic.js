import Vue from 'vue/dist/vue'
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

$(function() {
  const topicForm = Vue.extend({
    data: function() {
      return {
        LinkIconActive: false,
        ImageIconActive: false
      }
    },
    methods: {
      LinkIconDescriptionShow: function() {
        return this.LinkIconActive = true
      },
      LinkIconDescriptionHidden: function() {
        return this.LinkIconActive = false
      },
      ImageIconDescriptionShow: function() {
        return this.ImageIconActive = true
      },
      ImageIconDescriptionHidden: function() {
        return this.ImageIconActive = false
      }
    }
  })

  new topicForm().$mount('#topic-form-vue')

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

  $('[data-reply-id]').on('click', function() {
    const id = $(this).data('reply-id');
    const reply_text = `>>${id}`;
    const $inputText = $('textarea')
    const $text = $inputText.val()
    const $position = $('label[for="comment_body"]').offset()

    if($text.length === 0) {
      $inputText.val(reply_text);
    } else {
      $inputText.val(`${reply_text}\n${$text}`);
    }

    window.scroll($position.left, $position.top);
  })

});
