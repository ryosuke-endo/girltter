import Vue from 'vue/dist/vue'
import axios from 'axios/dist/axios'

axios.defaults.headers['X-CSRF-TOKEN'] = $('meta[name=csrf-token]').attr('content')

export default Vue.extend({
  props: {
    icons: {
      type: String
    },
    count: {
      type: String
    }
  },
  data() {
    return {
      localIcons: JSON.parse(this.icons),
      localCount: JSON.parse(this.count)
    }
  },
  methods: {
    spriteClass(icon) {
      const hexName = icon.image_file_name.replace(/(unicode\/|\.png)/, '')
      return `emoji-${hexName}`
    }
  },
  template: `
  <div class="c-container c-flex c-flex__wrap">
    <div class="p-emoji__container c-flex c-border c-border-r-5" v-for="icon in localIcons">
      <div :class="spriteClass(icon[0])">
      </div>
      <div class="p-emoji__counter">
        {{localCount[icon[0].id]}}
      </div>
    </div>
  </div>
  `
})
