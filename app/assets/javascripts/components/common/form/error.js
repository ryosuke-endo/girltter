import Vue from 'vue/dist/vue'

export default Vue.extend({
  props: {
    count: {
      type: Number,
      default: 0
    },
    messages: Array
  },
  template: `<div v-show="count">
               <div class="c-error_explanation">
                 <h2>
                   {{count}}つの入力エラーがあります
                 </h2>
                 <ul class="c-flash-message__messages">
                   <li v-for="message in messages" class="c-flash-message__message">
                   {{message}}
                   </li>
                 </ul>
               </div>
             </div>`
})
