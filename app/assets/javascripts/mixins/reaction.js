import Cookies from 'js-cookie'
import axios from 'axios/dist/axios'

axios.defaults.headers['X-CSRF-TOKEN'] = $('meta[name=csrf-token]').attr('content')

export default {
  methods: {
    createReaction(icon) {
      const self = this
      const params = {
        reactionable_id: this.reactionable_id,
        type: this.type,
        icon: icon
      }
      axios({
        method: "POST",
        url: `/api/reactions/${this.type}`,
        data: params
      })
      .then(function(res) {
        self.$store.dispatch('createReaction', res.data)
      })
      .catch(function(err) {
        console.log("createReaction fail")
      })
    },
    destroyReaction(icon) {
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
        self.$store.dispatch('destroyReaction', res.data)
        console.log("reactioned destroy success")
      })
      .catch(function(err) {
        console.log("reactioned destroy fail")
      })
    },
    submit(icon) {
      const user_reactioned_ids = this.type === "Topic" ?
        this.icons.topic.user_reactioned_ids : this.icons.comment[this.reactionable_id].user_reactioned_ids
      if(user_reactioned_ids.indexOf(icon.id) >= 0) {
        this.destroyReaction(icon)
      } else {
        this.createReaction(icon)
      }
    }
  }
}