import Vue from 'vue/dist/vue'
import icon from './components/comment/icon.js'

$(function() {
  const commentForm = Vue.extend({
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
