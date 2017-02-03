import Vue from 'vue/dist/vue'
import formError from './components/topic/form_error.js'
import fileUpload from './components/topic/file_upload.js'
import icon from './components/topic/icon.js'
import modal from './components/topic/modal.js'

$(function() {
  const topicForm = Vue.extend({
    data: function() {
      return {
        modalActive: false,
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
      'file-upload': fileUpload,
      'icon': icon,
      'modal': modal
    },

    methods: {
      showModal() {
        this.modalActive = true;
        this.scrollFix();
      },
      closeModal() {
        this.modalActive = false;
        this.releaseFix();
      },
      scrollFix() {
        $('body').addClass('p-topic-modal-is-overflow-hidden')
      },
      releaseFix() {
        $('body').removeClass('p-topic-modal-is-overflow-hidden');
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
