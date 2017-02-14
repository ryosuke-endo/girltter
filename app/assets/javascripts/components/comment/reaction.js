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
          category: "people",
          except: {
            unicode_version: '9.0',
            ios_version: '10.0'
          }
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
      </li>
      <li class="p-topic--icon--modal__base" v-show="iconListActive">
        <div class="p-topic--icon--modal">
          <div class="p-topic--icon--modal__head">
            <ul class="c-flex c-flex__jc-sb">
              <li class="p-topic--icon--modal__item--group"><i class="fa fa-clock-o"></i></li>
              <li class="p-topic--icon--modal__item--group"><i class="fa fa-smile-o"></i></li>
              <li class="p-topic--icon--modal__item--group"><i class="fa fa-leaf"></i></li>
              <li class="p-topic--icon--modal__item--group"><i class="fa fa-cutlery"></i></li>
              <li class="p-topic--icon--modal__item--group"><i class="fa fa-futbol-o"></i></li>
              <li class="p-topic--icon--modal__item--group"><i class="fa fa-plane"></i></li>
              <li class="p-topic--icon--modal__item--group"><i class="fa fa-lightbulb-o"></i></li>
              <li class="p-topic--icon--modal__item--group"><i class="fa fa-heart"></i></li>
              <li class="p-topic--icon--modal__item--group"><i class="fa fa-flag"></i></li>
            </ul>
          </div>
          <div class="p-topic--icon--modal__container">
            <h3 class="text--s-md">
              スマイリーと人々
            </h3>
            <ul class="c-flex c-flex__wrap">
              <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'People'">
                {{emoji.unicode_aliases[0]}}
              </li>
            </ul>
            <h3 class="text--s-md">
              動物と自然
            </h3>
            <ul class="c-flex c-flex__wrap">
              <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Nature'">
                {{emoji.unicode_aliases[0]}}
              </li>
            </ul>
            <h3 class="text--s-md">
              食べ物と飲み物
            </h3>
            <ul class="c-flex c-flex__wrap">
              <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Foods'">
                {{emoji.unicode_aliases[0]}}
              </li>
            </ul>
            <h3 class="text--s-md">
              活動
            </h3>
            <ul class="c-flex c-flex__wrap">
              <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Activity'">
                {{emoji.unicode_aliases[0]}}
              </li>
            </ul>
            <h3 class="text--s-md">
              旅行と場所
            </h3>
            <ul class="c-flex c-flex__wrap">
              <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Places'">
                {{emoji.unicode_aliases[0]}}
              </li>
            </ul>
            <h3 class="text--s-md">
              物
            </h3>
            <ul class="c-flex c-flex__wrap">
              <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Objects'">
                {{emoji.unicode_aliases[0]}}
              </li>
            </ul>
            <h3 class="text--s-md">
              記号
            </h3>
            <ul class="c-flex c-flex__wrap">
              <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Symbols'">
                {{emoji.unicode_aliases[0]}}
              </li>
            </ul>
            <h3 class="text--s-md">
              旗
            </h3>
            <ul class="c-flex c-flex__wrap">
              <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Flags'">
                {{emoji.unicode_aliases[0]}}
              </li>
            </ul>
          </div>
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
