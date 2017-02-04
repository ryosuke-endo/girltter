import Vue from 'vue/dist/vue'
import URI from 'urijs'
import icon from './components/comment/icon.js'

$(function() {
  const commentForm = Vue.extend({
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
      }
    },
    components: {
      'icon': icon
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
