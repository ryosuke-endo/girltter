import Vue from 'vue/dist/vue'
import Modal from './topic/modal/modal'
import Tab from './topic/modal/tab'
import Form from './topic/modal/form'

const $target = $('[data-modal__contents]');
const params = new Map().set('fadeout', false)

const modal = new Modal($target, params);
const tab = new Tab;
const form = new Form;

const CONTENT_TYPE = [
  'image/jpg',
  'image/jpeg',
  'image/png',
  'image/gif',
  'image/bmp',
]

$(function() {
  const topicForm = Vue.extend({
    data: function() {
      return {
        LinkIconActive: false,
        ImageIconActive: false,
        image: '',
        reader: new FileReader()
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
      },
      onFileChange: function(e) {
        const file = e.target.files[0]
        if(this.isContent(CONTENT_TYPE, file)) {
          this.previewImage(file)
        }
      },
      isContent: function(type, file) {
        return type.indexOf(file.type) !== -1
      },
      previewImage: function(file) {
        this.reader.readAsDataURL(file)
        this.reader.onload = (file) => {
          this.image = file.target.result
        }
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
