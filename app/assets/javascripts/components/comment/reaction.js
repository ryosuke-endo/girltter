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
    this.getEmoji()
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
    },
    getEmoji() {
      self = this
      const query = {
        query: {
          category: "people"
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
    }
  },
  template: `
  <div class="p-topic-icon text--s-x-lg">
    <ul class="c-flex c-flex__jc-end c-container">
      <li class="p-topic-icon__item" @click="showIconList "@mouseenter="showReaction" @mouseleave="hiddenReaction">
        <i class="fa fa-smile-o"></i>
          <div class="p-topic--icon__description text--s-sm text--c" v-show="reactionActive">
            絵文字をつける
          </div>
          <div class="p-topic--icon--modal" v-show="iconListActive">
            <div class="p-topic--icon--modal__head">
              <ul class="c-flex c-flex__jc-sb">
                <li><i class="fa fa-clock-o"></i></li>
                <li><i class="fa fa-smile-o"></i></li>
                <li><i class="fa fa-leaf"></i></li>
                <li><i class="fa fa-cutlery"></i></li>
                <li><i class="fa fa-futbol-o"></i></li>
                <li><i class="fa fa-plane"></i></li>
                <li><i class="fa fa-lightbulb-o"></i></li>
                <li><i class="fa fa-heart"></i></li>
                <li><i class="fa fa-flag"></i></li>
              </ul>
            </div>
            <ul class="c-flex c-flex__wrap">
              <li class="p-topic--icon__list" v-for="emoji in emojis">
                {{emoji.unicode_aliases[0]}}
              </li>
            </ul>
          </div>
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
