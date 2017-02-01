import Vue from 'vue/dist/vue'
import Modal from './topic/modal/modal'
import Tab from './topic/modal/tab'
import Form from './topic/modal/form'
import formError from './components/topic/form_error.js'
import fileUpload from './components/topic/file_upload.js'

const $target = $('[data-modal__contents]');
const params = new Map().set('fadeout', false)

const modal = new Modal($target, params);
const tab = new Tab;
const form = new Form;

$(function() {
  const topicForm = Vue.extend({
    data: function() {
      return {
        linkIconActive: false,
        imageIconActive: false,
        categories: [],
        topic: {
          title: '',
          body: '',
          category_id: '',
          name: '匿子さん',
          thumbnail: '',
          errors: {
            count: 0,
            keys: [],
            messages: []
          }
        },
      }
    },

    created: function()
    {
      self = this
      $.ajax({
        url: '/api/categories.json',
      }).done(function(res) {
          self.categories = res
        })
    },
    mounted: function() {
      this.getCategoryId()
    },

    components: {
      'form-error': formError,
      'file-upload': fileUpload
    },

    methods: {
      linkIconDescriptionShow: function() {
        return this.linkIconActive = true
      },
      linkIconDescriptionHidden: function() {
        return this.linkIconActive = false
      },
      imageIconDescriptionShow: function() {
        return this.imageIconActive = true
      },
      imageIconDescriptionHidden: function() {
        return this.imageIconActive = false
      },
      getCategoryId: function() {
        const id = parseInt(location.href.match(/\d$/).join(''))
        return this.topic.category_id = id
      },
      selectCategoryId: function(e) {
        this.topic.category_id = e.target.value
      },
      isSelected: function(id) {
        return this.topic.category_id === id
      },
      previewImage: function(e) {
        return this.topic.thumbnail = e
      },
      send: function() {
        self = this
        const topic_params = {
          topic: self.topic
        }
        $.ajax({
          url: "/api/topics",
          method: "POST",
          data: topic_params
        }).done(function(res) {
          location.href = `/topics/complete?id=${res.id}`
        }).fail(function(res) {
          self.topic.errors.count = parseInt(Object.keys(res.responseJSON.errors).length)
          self.topic.errors.keys = res.responseJSON.errors
          self.topic.errors.messages = res.responseJSON.error_messages
        })
      },
      isError: function(name) {
        if (this.topic.errors.keys[name]) {
          return "field_with_errors"
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
