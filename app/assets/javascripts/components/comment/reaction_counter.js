import Vue from 'vue/dist/vue'
import { mapState } from 'vuex/dist/vuex'
import reactionMixins from './../../mixins/reaction.js'

export default Vue.extend({
  mixins: [reactionMixins],
  props: {
    reactionable_id: {
      type: String
    },
    type: {
      type: String
    }
  },
  methods: {
    filterIcons() {
      if (this.type == "Topic") {
        return this.icons.topic
      } else {
        return this.icons.comment[this.reactionable_id]
      }
    },
    hexName(icon) {
      return icon.image_file_name.replace(/(unicode\/|\.png)/, '')
    },
    isReactioned(icon) {
      if(typeof(icon) !== "object") {
        return "none"
      }
      const ids = this.type === "Topic" ?
        this.icons.topic.user_reactioned_ids : this.icons.comment[this.reactionable_id].user_reactioned_ids
      if (ids === undefined) {
        return
      }
      if (ids.indexOf(icon.id) >= 0) {
        return "is-active"
      }
    },
    reactionCount(icon) {
      if(typeof(icon) !== "object") {
        return
      }
      const count = this.type === "Topic" ?
        this.icons.topic[icon.id].length : this.icons.comment[this.reactionable_id][icon.id].length
      return count
    },
    spriteClass(icon) {
      if(typeof(icon) !== "object") {
        return
      }
      return `emoji-${this.hexName(icon)}`
    }
  },
  computed: mapState([
    'icons',
    'visiable',
    'errorReaction'
  ]),
  template: `
  <div class="c-container c-flex c-flex__wrap" v-if="visiable">
    <div v-for="icon in filterIcons()" class="p-emoji__container c-flex c-border c-border-r-5" :class="isReactioned(icon[0])" @click="submit(icon[0])">
      <div :class="spriteClass(icon[0])">
      </div>
      <div class="p-emoji__counter">
        {{reactionCount(icon[0])}}
      </div>
    </div>
  </div>
  `
})
