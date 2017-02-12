import Vue from 'vue/dist/vue'
import axios from 'axios/dist/axios'

axios.defaults.headers['X-CSRF-TOKEN'] = $('meta[name=csrf-token]').attr('content')
export default Vue.extend({
  props: {
    reply_id: {
      type: String
    }
  },
  data() {
    return {
      iconListActive: true,
      replyActive: false,
      reactionActive: false,
      emojis: []
    }
  },
  mounted() {
    self = this
    const query = {
      query: {
        name: "thumbsup"
      }
    }
    axios({
      method: 'GET',
      url: "/api/emoji",
      params: query
    })
    .then(function(res) {
      console.log(res.data)
      self.emojis = res.data
    }).catch(function(error) {
      console.log(error)
    })
  },
  methods: {
    submitReply() {
      this.$emit('reply', this.reply_id)
    },
    showReply() {
      this.replyActive = true
    },
    hiddenReply() {
      this.replyActive = false
    },
    showReaction() {
      this.reactionActive = true
    },
    hiddenReaction() {
      this.reactionActive = false
    },
    showIconList() {
      this.iconListActive = true
    },
    hiddenIconList() {
      this.iconListActive = false
    }
  },
  template: `
  <div class="p-topic-icon text--s-x-lg">
    <ul class="c-flex c-flex__jc-end c-container">
      <li class="p-topic-icon__item" @click="showIconList "@mouseenter="showReaction" @mouseleave="hiddenReaction">
        <i class="fa fa-smile-o"></i>
          <div class="p-topic--icon__description text--s-sm text--c " v-show="reactionActive">
            絵文字をつける
          </div>
          <div class="p-topic--icon-list" v-show="iconListActive">
          <ul v-for="emoji in emojis">
            <li>{{emoji["moji"]}}</li>
          </div>
        </i>
      </li>
      <li class="p-topic-icon__item" @click=submitReply @mouseenter="showReply" @mouseleave="hiddenReply">
        <i class="fa fa-reply">
          <div class="p-topic--icon__description text--s-sm text--c text--b" v-show="replyActive">
            返信する
          </div>
        </i>
      </li>
    </ul>
  </div>
    `
})
