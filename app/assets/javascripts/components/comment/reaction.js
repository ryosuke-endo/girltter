import Vue from 'vue/dist/vue'
import axios from 'axios/dist/axios'

axios.defaults.headers['X-CSRF-TOKEN'] = $('meta[name=csrf-token]').attr('content')
export default Vue.extend({
  props: {
    reply_id: {
      type: String
    },
    emoji_path: {
      type: String
    }
  },
  data() {
    return {
      iconListActive: false,
      replyActive: false,
      reactionActive: false,
      emojis: [],
      categoryHeaders: {}
    }
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
    showIconList(e) {
      this.iconListActive = true
      this.getEmoji(e)
    },
    hiddenIconList() {
      this.iconListActive = false
    },
    scrollCategoryHeader(category) {
      const $target = $(".p-topic--icon--modal__container")
      $target.scrollTop(0)
      const top = this.categoryHeaders[category].top - 40
      $target.scrollTop(top)
    },
    getCategoryHeaderPosition(event) {
      const targets = $(event.target).
        parent().
        next().
        find('#people, #nature, #foods, #activity, #places, #objects, #symbols, #flags')
      const categories = {}
      targets.each(function(i, target) {
        const $target = $(target)
        const key = $target.context.id
        categories[key] = $target.position()
      })
      return this.categoryHeaders = categories
    },
    getEmoji(e) {
      self = this
      const event = e
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
        if(Object.keys(self.categoryHeaders).length === 0) {
          const image = new Image();
          image.onload = function() {
            self.getCategoryHeaderPosition(event)
          }
          image.src = self.emoji_path
        }
        self.emojis = res.data
      }).catch(function(error) {
        console.log(error)
      })
    }
  },
  template: `
  <div class="p-topic-icon text--s-x-lg">
    <ul class="c-flex c-flex__jc-end c-container">
      <li class="p-topic-icon__item" @click="showIconList($event)"@mouseenter="showReaction" @mouseleave="hiddenReaction">
        <i class="fa fa-smile-o"></i>
          <div class="p-topic--icon__description text--s-sm text--c" v-show="reactionActive">
            絵文字をつける
          </div>
      </li>
      <li class="p-topic--icon--modal__base" v-show="iconListActive">
        <div class="p-topic--icon--modal">
          <div class="p-topic--icon--modal__head">
            <ul class="c-flex c-flex__jc-sb p-topic--icon--modal__item--tabs">
              <li class="p-topic--icon--modal__item--tab text--c c-icon-d-gray is-active"><i class="fa fa-clock-o"></i></li>
              <a href="#" @click.prevent="scrollCategoryHeader('people')">
                <li class="p-topic--icon--modal__item--tab c-icon-d-gray text--c">
                  <i class="fa fa-smile-o">
                  </i>
                </li>
              </a>
              <a href="#" @click.prevent="scrollCategoryHeader('nature')">
                <li class="p-topic--icon--modal__item--tab c-icon-d-gray text--c">
                  <i class="fa fa-leaf">
                  </i>
                </li>
              </a>
              <a href="#" @click.prevent="scrollCategoryHeader('foods')">
                <li class="p-topic--icon--modal__item--tab c-icon-d-gray text--c">
                  <i class="fa fa-cutlery">
                  </i>
                </li>
              </a>
              <a href="#" @click.prevent="scrollCategoryHeader('activity')">
                <li class="p-topic--icon--modal__item--tab c-icon-d-gray text--c">
                  <i class="fa fa-futbol-o">
                  </i>
                </li>
              </a>
              <a href="#"  @click.prevent="scrollCategoryHeader('places')">
                <li class="p-topic--icon--modal__item--tab c-icon-d-gray text--c">
                  <i class="fa fa-plane">
                  </i>
                </li>
              </a>
              <a href="#" @click.prevent="scrollCategoryHeader('objects')">
                <li class="p-topic--icon--modal__item--tab c-icon-d-gray text--c">
                  <i class="fa fa-lightbulb-o">
                  </i>
                </li>
              </a>
              <a href="#" @click.prevent="scrollCategoryHeader('symbols')">
                <li class="p-topic--icon--modal__item--tab c-icon-d-gray text--c">
                  <i class="fa fa-heart">
                  </i>
                </li>
              </a>
              <a href="#" @click.prevent="scrollCategoryHeader('flags')">
                <li class="p-topic--icon--modal__item--tab c-icon-d-gray text--c">
                  <i class="fa fa-flag">
                  </i>
                </li>
              </a>
            </ul>
          </div>
          <div class="p-topic--icon--modal__container">
            <h3 id="people" class="text--s-md">
              スマイリーと人々
            </h3>
            <ul class="c-flex c-flex__wrap">
              <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'People'">
                <div :class="emoji.style_class">
              </li>
            </ul>
            <h3 id="nature" class="text--s-md">
              動物と自然
            </h3>
            <ul class="c-flex c-flex__wrap">
              <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Nature'">
                <div :class="emoji.style_class">
              </li>
            </ul>
            <h3 id="foods" class="text--s-md">
              食べ物と飲み物
            </h3>
            <ul class="c-flex c-flex__wrap">
              <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Foods'">
                <div :class="emoji.style_class">
              </li>
            </ul>
            <h3 id="activity"class="text--s-md">
              活動
            </h3>
            <ul class="c-flex c-flex__wrap">
              <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Activity'">
                <div :class="emoji.style_class">
              </li>
            </ul>
            <h3 id="places" class="text--s-md">
              旅行と場所
            </h3>
            <ul class="c-flex c-flex__wrap">
              <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Places'">
                <div :class="emoji.style_class">
              </li>
            </ul>
            <h3 id="objects" class="text--s-md">
              物
            </h3>
            <ul class="c-flex c-flex__wrap">
              <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Objects'">
                <div :class="emoji.style_class">
              </li>
            </ul>
            <h3 id="symbols" class="text--s-md">
              記号
            </h3>
            <ul class="c-flex c-flex__wrap">
              <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Symbols'">
                <div :class="emoji.style_class">
              </li>
            </ul>
            <h3 id="flags" class="text--s-md">
              旗
            </h3>
            <ul class="c-flex c-flex__wrap">
              <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Flags'">
                <div :class="emoji.style_class">
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
