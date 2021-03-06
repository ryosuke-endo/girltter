import Vue from 'vue/dist/vue'
import { mapState } from 'vuex/dist/vuex'
import URI from 'urijs'
import axios from 'axios/dist/axios'
import store from './store.js'

import modalMixins from './mixins/modal.js'
import icon from './components/comment/icon.js'
import modal from './components/common/form/modal'
import reaction from './components/comment/reaction.js'
import reactionCounter from './components/comment/reaction_counter.js'
import reactionError from './components/comment/reaction_error.js'
import formError from './components/common/form/error.js'

import AnchorRes from './anchor_res.js'

axios.defaults.headers['X-CSRF-TOKEN'] = $('meta[name=csrf-token]').attr('content')

$(function() {
  const commentForm = Vue.extend({
    store,
    mixins: [modalMixins],
    data() {
      return {
        comment: {
          name: '匿子さん',
          body: '',
          image: '',
          topic_id: '',
          errors: {
            count: 0,
            key: [],
            messages: []
          }
        }
      }
    },
    components: {
      'form-error': formError,
      'icon': icon,
      'modal': modal,
      'reaction': reaction,
      'reaction-counter': reactionCounter,
      'reaction-error': reactionError
    },
    created() {
      this.$store.dispatch('fetchReaction').then(() =>
        this.$store.dispatch('canVisiable')
      )
      this.getTopicId()
    },
    computed: mapState([
      'visiable',
      'errorReaction'
    ]),
    methods: {
      getTopicId() {
        const url = URI(location.href)
        this.comment.topic_id = url.path().match(/\d.*$/)[0]
      },
      imageDelete() {
        this.comment.image = ''
      },
      addUrl(url) {
        const text = this.comment.body
        if(text.length === 0) {
          this.comment.body = url
        } else {
          this.comment.body = (`${text}\n\n${url}`)
        }
      },
      reply(id) {
        const text = this.comment.body
        const $position = $('[data-text-area]').offset()

        if(text.length === 0) {
          this.comment.body = `>>${id}`
        } else {
          this.comment.body = `${text}\n>>${id}`
        }

        window.scroll($position.left, $position.top);
      },
      submit() {
        self = this
        const comment_params = {
          comment: self.comment
        }
        const url = `/api${URI(location.href).path()}/comments`
        axios({
          method: "post",
          url: url,
          data: comment_params
        })
        .then(function(res) {
          location.href = `/topics/complete?id=${res.data.topic_id}`
        })
        .catch(function(error) {
          self.comment.errors.count = parseInt(Object.keys(error.response.data.errors).length)
          self.comment.errors.keys = error.response.data.errors
          self.comment.errors.messages = error.response.data.error_messages
        })
      }
    }
  })

  const vueDom = new commentForm().$mount('#vue')

  $('.js-modal-backdrop').on('click', function() {
    vueDom.$root.$children.forEach(function(val) {
      if (val.$data.iconListActive === true) {
        val.$data.iconListActive = false
      }
    })
    $('body').removeClass('js-menu-active')
  })

  $('[data-anchor]').on('click', function(e) {
    new AnchorRes(e).send()
  })
})
