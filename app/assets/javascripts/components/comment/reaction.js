import Vue from 'vue/dist/vue'

export default Vue.extend({
  data() {
    return {
      reply_id: ''
    }
  },
  template: `
  <div class="p-topic-icon text--s-x-lg">
    <ul class="c-flex c-flex__jc-end c-container">
      <li class="p-topic-icon__item p-topic-icon__smile">
        <i class="fa fa-smile-o"></i>
      </li>
      <li class="p-topic-icon__item">
        <i class="fa fa-reply"></i>
      </li>
    </ul>
  </div>
    `
})
