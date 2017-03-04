import Vue from 'vue/dist/vue'
import axios from 'axios/dist/axios'

axios.defaults.headers['X-CSRF-TOKEN'] = $('meta[name=csrf-token]').attr('content')

export default Vue.extend({
  props: {
    after: {
      type: String
    },
    count: {
      type: String
    }
  },
  template: `
  <div class="p-emoji__container c-flex c-border c-border-r-5">
    <div :class="after">
    </div>
    <div class="p-emoji__counter">
      {{count}}
    </div>
  </div>
  `
})
