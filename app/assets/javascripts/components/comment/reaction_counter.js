import Vue from 'vue/dist/vue'
import { mapState } from 'vuex/dist/vuex'
import axios from 'axios/dist/axios'
import Cookies from 'js-cookie'

axios.defaults.headers['X-CSRF-TOKEN'] = $('meta[name=csrf-token]').attr('content')

export default Vue.extend({
  props: {
    reactionable_id: {
      type: String
    },
    type: {
      type: String
    }
  },
  methods: {
    hexName(icon) {
      return icon.image_file_name.replace(/(unicode\/|\.png)/, '')
    },
    spriteClass(icon) {
      if(typeof(icon) !== "object") {
        return
      }
      return `emoji-${this.hexName(icon)}`
    },
    reactionCount(icon) {
      if(typeof(icon) !== "object") {
        return
      }
      const count = this.type === "Topic" ?
        this.icons.topic[icon.id].length : this.icons.comment[this.reactionable_id][icon.id].length
      return count
    },
    create(icon) {
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
        self.$store.dispatch('addIcon', res.data)
        self.isReactioned(icon)
      })
      .catch(function(err) {
        console.log("reactioned fail")
      })
    },
    destroy(icon) {
      const self = this
      const params = {
        reactionable_id: this.reactionable_id,
        type: this.type,
        icon_id: icon.id,
        identity_id: Cookies.get("_cadr")
      }
      axios({
        method: "POST",
        url: `/api/reactions/${this.type}/${this.reactionable_id}`,
        data: params
      })
      .then(function(res) {
        console.log("reactioned destroy success")
        self.$store.dispatch('destroyIcon', res.data)
      })
      .catch(function(err) {
        console.log("reactioned fail")
      })
      console.log("delete")
    },
    submit(icon) {
      const user_reactioned_ids = this.type === "Topic" ?
        this.icons.topic.user_reactioned_ids : this.icons.comment[this.reactionable_id].user_reactioned_ids
      if(user_reactioned_ids.indexOf(icon.id) >= 0) {
        this.destroy(icon)
      } else {
        this.create(icon)
      }
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
    filterIcons() {
      if (this.type == "Topic") {
        return this.icons.topic
      } else {
        return this.icons.comment[this.reactionable_id]
      }
    }
  },
  computed: mapState([
    'icons',
    'visiable'
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
