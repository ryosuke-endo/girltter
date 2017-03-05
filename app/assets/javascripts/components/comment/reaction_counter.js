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
    },
    reactionable_id: {
      type: String
    },
    type: {
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
    },
    reactionCount(icon) {
      if (this.type === "Comment") {
        return this.localCount.comment[`[${this.reactionable_id}, ${icon.id}]`]
      } else if (this.type === "Topic") {
        return this.localCount.topic[icon.id]
      }
    }
  },
  template: `
  <div class="c-container c-flex c-flex__wrap">
    <div class="p-emoji__container c-flex c-border c-border-r-5" v-for="icon in localIcons">
      <div :class="spriteClass(icon[0])">
      </div>
      <div class="p-emoji__counter">
        {{reactionCount(icon[0])}}
      </div>
    </div>
  </div>
  `
})
