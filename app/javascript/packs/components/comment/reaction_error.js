import Vue from 'vue/dist/vue'
import { mapState } from 'vuex/dist/vuex'

export default Vue.extend({
  methods: {
    closeModal() {
      this.$store.dispatch('closeModal')
    }
  },
  computed: mapState([
    'errorReaction'
  ]),
  template: `
  <transition name="topic-modal-fade">
    <div id="topic-modal">
      <div class="topic-modal__content">
        <div class="p-topic-modal__head text--c text--b">
          絵文字をつけるのが最大数に達しています
          <i class="fa fa-close c-icon-d-gray p-topic-modal__icon__close" @click="closeModal">
          </i>
        </div>
        <div class="p-topic-modal__body">
          <ul class="p-emoji-modal__contents c-flex--column c-flex__ai-c c-flex--jc-c">
            <li v-for="message in errorReaction.messages">
            {{message}}
            </li>
          </ul>
          </div>
        </div>
      </div>
    </div>
  </transition>
  `
})
