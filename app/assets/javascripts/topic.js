import Vue from 'vue/dist/vue'
import axios from 'axios/dist/axios'

import formError from './components/topic/form_error.js'
import fileUpload from './components/topic/file_upload.js'
import icon from './components/topic/icon.js'
import modal from './components/topic/modal.js'

axios.defaults.headers['X-CSRF-TOKEN'] = $('meta[name=csrf-token]').attr('content')

$(function() {
  const topicForm = Vue.extend({
    data() {
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

    created()
    {
      self = this
      axios.get('/api/categories.json')
      .then(function(res) {
        self.categories = res.data
      })
    },
    mounted() {
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
      getCategoryId() {
        const id = parseInt(location.href.match(/\d$/).join(''))
        return this.topic.category_id = id
      },
      selectCategoryId(e) {
        this.topic.category_id = e.target.value
      },
      isSelected(id) {
        return this.topic.category_id === id
      },
      addUrl(url) {
        const text = this.topic.body
        if(text.length === 0) {
          this.topic.body = url
        } else {
          this.topic.body = (`${text}\n\n${url}`)
        }
      },
      send() {
        self = this
        const topic_params = {
          topic: self.topic
        }
        axios({
          method: "post",
          url: "/api/topics",
          data: topic_params
        })
        .then(function(res) {
          location.href = `/topics/complete?id=${res.id}`
        })
        .catch(function(error) {
          self.topic.errors.count = parseInt(Object.keys(error.response.data.errors).length)
          self.topic.errors.keys = error.response.data.errors
          self.topic.errors.messages = error.response.data.error_messages
        })
      },
      isError(name) {
        if (this.topic.errors.keys[name]) {
          return "field_with_errors"
        }
      }
    }
  })
  new topicForm().$mount('#topic-form-vue')
});
