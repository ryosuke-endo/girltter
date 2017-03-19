import Vue from 'vue/dist/vue'
import { mapState } from 'vuex/dist/vuex'
import axios from 'axios/dist/axios'
import reactionMixins from './../../mixins/reaction.js'
import 'babel-polyfill'

axios.defaults.headers['X-CSRF-TOKEN'] = $('meta[name=csrf-token]').attr('content')
export default Vue.extend({
  mixins: [reactionMixins],
  props: {
    reply_id: {
      type: String
    },
    emoji_path: {
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
    hiddenIconList() {
      this.iconListActive = false
    },
    showIconList() {
      const self = this
      $('body').addClass('js-menu-active')
      Promise.all([self.fetchEmoji(), self.fetchEmojiImage()])
      .then(function() {
        self.iconListActive = true
        self.$nextTick(function() {
          self.getCategoryHeaderPosition()
          self.watchPosition()
        })
      })
    },
    scrollCategoryHeader(category) {
      const $target = $(this.$el.querySelector(".p-topic--icon--modal__container"))
      $target.scrollTop(0)
      const top = this.categoryHeaders[category].top - 40
      $target.scrollTop(top)
    },
    getCategoryHeaderPosition() {
      const targets = $(this.$el.querySelectorAll('#people, #nature, #foods, #activity, #places, #objects, #symbols, #flags'))
      const categories = {}
      targets.each(function(i, target) {
        const $target = $(target)
        const key = $target.context.id
        categories[key] = $target.position()
      })
      return this.categoryHeaders = categories
    },
    fetchEmoji() {
      return new Promise((resolve, reject) => {
        const self = this
        const query = {
          query: {
            except: {
              unicode_version: '9.0',
              ios_version: '10.0'
            }
          }
        }
        axios({
          method: 'GET',
          url: "/api/icon",
          params: query
        })
        .then(function(res) {
          self.emojis = res.data;
          return resolve()
        }).catch(function(error) {
          console.log(error);
        });
      });
    },
    fetchEmojiImage() {
      const self = this
      return new Promise((resolve, reject) => {
        if(Object.keys(self.categoryHeaders).length === 0) {
          const image = new Image();
          image.src = self.emoji_path;
          image.onload = function() {
            return resolve()
          }
        }
        return resolve()
      })
    },
    watchPosition() {
      const self = this
      const $point = $(self.$el.querySelector(".p-topic--icon--modal__container"))
      $point.on('scroll', function() {
        for(let category in self.categoryHeaders) {
          const categoryPosition = self.categoryHeaders[category].top - 45
          const $height = $(self.$el.querySelector(`#${category}`)).height() - 45
          const $position = $point.scrollTop()
          if( categoryPosition < $position && $position < categoryPosition + $height) {
            $('.p-topic--icon--modal__head a').removeClass("is-active")
            $('.p-topic--icon--modal__head a').filter(function(index) {
              return this.hash === `#${category}`
            })
            .addClass("is-active");
          }
        }
      })
    }
  },
  computed: mapState([
    'icons'
  ]),
  template: `
  <div class="p-topic-icon text--s-x-lg">
    <ul class="c-flex c-flex__jc-end c-container">
      <li class="p-topic-icon__item" @click="showIconList" @mouseenter="showReaction" @mouseleave="hiddenReaction">
        <i class="fa fa-smile-o"></i>
          <div class="p-topic--icon__description text--s-sm text--c" v-show="reactionActive">
            絵文字をつける
          </div>
      </li>
      <li class="p-topic--icon--modal__base" v-show="iconListActive">
        <div class="p-topic--icon--modal">
          <div class="p-topic--icon--modal__head">
            <ul class="c-flex c-flex__jc-sb p-topic--icon--modal__item--tabs">
              <li class="p-topic--icon--modal__item--tab text--c c-icon-d-gray is-active">
                <i class="fa fa-clock-o"></i>
              </li>
              <a href="#people" class="is-active" @click.prevent="scrollCategoryHeader('people')">
                <li class="p-topic--icon--modal__item--tab c-icon-d-gray text--c">
                  <i class="fa fa-smile-o">
                  </i>
                </li>
              </a>
              <a href="#nature" @click.prevent="scrollCategoryHeader('nature')">
                <li class="p-topic--icon--modal__item--tab c-icon-d-gray text--c">
                  <i class="fa fa-leaf">
                  </i>
                </li>
              </a>
              <a href="#foods" @click.prevent="scrollCategoryHeader('foods')">
                <li class="p-topic--icon--modal__item--tab c-icon-d-gray text--c">
                  <i class="fa fa-cutlery">
                  </i>
                </li>
              </a>
              <a href="#activity" @click.prevent="scrollCategoryHeader('activity')">
                <li class="p-topic--icon--modal__item--tab c-icon-d-gray text--c">
                  <i class="fa fa-futbol-o">
                  </i>
                </li>
              </a>
              <a href="#places"  @click.prevent="scrollCategoryHeader('places')">
                <li class="p-topic--icon--modal__item--tab c-icon-d-gray text--c">
                  <i class="fa fa-plane">
                  </i>
                </li>
              </a>
              <a href="#objects" @click.prevent="scrollCategoryHeader('objects')">
                <li class="p-topic--icon--modal__item--tab c-icon-d-gray text--c">
                  <i class="fa fa-lightbulb-o">
                  </i>
                </li>
              </a>
              <a href="#symbols" @click.prevent="scrollCategoryHeader('symbols')">
                <li class="p-topic--icon--modal__item--tab c-icon-d-gray text--c">
                  <i class="fa fa-heart">
                  </i>
                </li>
              </a>
              <a href="#flags" @click.prevent="scrollCategoryHeader('flags')">
                <li class="p-topic--icon--modal__item--tab c-icon-d-gray text--c">
                  <i class="fa fa-flag">
                  </i>
                </li>
              </a>
            </ul>
          </div>
          <div class="p-topic--icon--modal__container">
            <div id="people">
              <h3 class="c-container--sm text--s-md">
                スマイリーと人々
              </h3>
              <ul class="c-flex c-flex__wrap">
                <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'People'">
                  <div :class="emoji.style_class" @click="submit(emoji)">
                </li>
              </ul>
            </div>
            <div id ="nature">
              <h3 class="c-container--sm text--s-md">
                動物と自然
              </h3>
              <ul class="c-flex c-flex__wrap">
                <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Nature'">
                  <div :class="emoji.style_class" @click="submit(emoji)">
                </li>
              </ul>
            </div>
            <div id="foods">
              <h3 class="c-container--sm text--s-md">
                食べ物と飲み物
              </h3>
              <ul class="c-flex c-flex__wrap">
                <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Foods'">
                  <div :class="emoji.style_class" @click="submit(emoji)">
                </li>
              </ul>
            </div>
            <div id="activity">
              <h3 class="c-container--sm text--s-md">
                活動
              </h3>
              <ul class="c-flex c-flex__wrap">
                <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Activity'">
                  <div :class="emoji.style_class" @click="submit(emoji)">
                </li>
              </ul>
            </div>
            <div id="places">
              <h3 class="c-container--sm text--s-md">
                旅行と場所
              </h3>
              <ul class="c-flex c-flex__wrap">
                <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Places'">
                  <div :class="emoji.style_class" @click="submit(emoji)">
                </li>
              </ul>
            </div>
            <div id="objects">
              <h3 class="c-container--sm text--s-md">
                物
              </h3>
              <ul class="c-flex c-flex__wrap">
                <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Objects'">
                  <div :class="emoji.style_class" @click="submit(emoji)">
                </li>
              </ul>
            </div>
            <div id="symbols">
              <h3 class="c-container--sm text--s-md">
                記号
              </h3>
              <ul class="c-flex c-flex__wrap">
                <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Symbols'">
                  <div :class="emoji.style_class" @click="submit(emoji)">
                </li>
              </ul>
            </div>
            <div id="flags">
              <h3 class="c-container--sm text--s-md">
                旗
              </h3>
              <ul class="c-flex c-flex__wrap">
                <li class="p-topic--icon__list" v-for="emoji in emojis" v-if="emoji.category == 'Flags'">
                  <div :class="emoji.style_class" @click="submit(emoji)">
                </li>
              </ul>
            </div>
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
