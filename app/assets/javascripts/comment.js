import Vue from 'vue/dist/vue'
import URI from 'urijs'

import modalMixins from './mixins/modal.js'
import icon from './components/comment/icon.js'
import modal from './components/topic/modal'

$(function() {
  const commentForm = Vue.extend({
    mixins: [modalMixins],
    data() {
      return {
        comment: {
          name: '匿子さん',
          body: '',
          image: '',
          topic_id: ''
        }
      }
    },
    mounted() {
      this.getTopicId()
    },
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
    },
    components: {
      'icon': icon,
      'modal': modal
    }
  })

  new commentForm().$mount('#comment-form-vue')

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
})
