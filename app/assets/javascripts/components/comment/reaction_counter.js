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
    hexName(icon) {
      return icon.image_file_name.replace(/(unicode\/|\.png)/, '')
    },
    spriteClass(icon) {
      return `emoji-${this.hexName(icon)}`
    },
    reactionCount(icon) {
      if (this.type === "Comment") {
        return this.localCount.comment[`[${this.reactionable_id}, ${icon.id}]`]
      } else if (this.type === "Topic") {
        return this.localCount.topic[icon.id]
      }
    },
    submit(icon) {
      const self = this
      const params = {
        reactionable_id: this.reactionable_id,
        type: this.type,
        icon: {
          name: this.hexName(icon)
        }
      }
      axios({
        method: "POST",
        url: `/api/reactions/${this.type}`,
        data: params
      })
      .then(function(res) {
        console.log("success")
        return self.localCount.comment[`[${self.reactionable_id}, ${icon.id}]`] += 1
      })
      .catch(function(err) {
        console.log("fail")
      })
    }
  },
  template: `
  <div class="c-container c-flex c-flex__wrap">
    <div class="p-emoji__container c-flex c-border c-border-r-5" v-for="icon in localIcons" @click="submit(icon[0])">
      <div :class="spriteClass(icon[0])">
      </div>
      <div class="p-emoji__counter">
        {{reactionCount(icon[0])}}
      </div>
    </div>
  </div>
  `
})
