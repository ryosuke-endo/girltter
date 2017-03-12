import Vue from 'vue/dist/vue'
import { mapState } from 'vuex/dist/vuex'
import axios from 'axios/dist/axios'

axios.defaults.headers['X-CSRF-TOKEN'] = $('meta[name=csrf-token]').attr('content')

export default Vue.extend({
  props: {
    icons: {
      type: String
    },
    reactionable_id: {
      type: String
    },
    type: {
      type: String
    },
    reactioned_ids: {
      type: String
    }
  },
  data() {
    return {
      localIcons: JSON.parse(this.icons),
      localReactionedIds: JSON.parse(this.reactioned_ids)
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
        return this.count.comment[`[${this.reactionable_id}, ${icon.id}]`]
      } else if (this.type === "Topic") {
        return this.count.topic[icon.id]
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
        console.log("reactionedr success")
        self.localReactionedIds.push(icon.id)
        self.isReactioned(icon)
        return self.count.comment[`[${self.reactionable_id}, ${icon.id}]`] += 1
      })
      .catch(function(err) {
        console.log("reactioned fail")
      })
    },
    isReactioned(icon) {
      if(this.localReactionedIds.indexOf(icon.id) >= 0) {
        return "is-active"
      }
    }
  },
  computed: mapState([
    'count',
    'visiable'
  ]),
  template: `
  <div class="c-container c-flex c-flex__wrap" v-if="visiable">
    <div :class="isReactioned(icon[0])" class="p-emoji__container c-flex c-border c-border-r-5" v-for="icon in localIcons" @click="submit(icon[0])">
      <div :class="spriteClass(icon[0])">
      </div>
      <div class="p-emoji__counter">
        {{reactionCount(icon[0])}}
      </div>
    </div>
  </div>
  `
})
