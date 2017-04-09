import Vue from 'vue/dist/vue'
import URI from 'urijs'

export default Vue.extend({
  data() {
    return {
      url: '',
      error: false
    }
  },
  methods: {
    closeModal() {
      this.$emit('close')
    },
    submit() {
      const url = URI(this.url)
      if(url.hostname().length !== 0) {
        this.$emit('url', this.url)
        this.url = ''
        return this.closeModal()
      }
      this.error = true
    },
    updateUrl(e) {
      this.error = false
      this.url = e.target.value
    },
  },
  template: `
  <transition name="topic-modal-fade">
    <div id="topic-modal">
      <div class="topic-modal__content">
        <div class="p-topic-modal__head text--c text--b">
          画像/記事を引用する
          <i class="fa fa-close c-icon-d-gray p-topic-modal__icon__close" @click="closeModal">
          </i>
        </div>
        <div class="p-topic-modal__body c-flex">
          <ul class="p-topic-modal__nav">
            <li class="is-active">
              <i class="fa fa-link c-icon-d-gray text--s-lg p-topic-modal__icon">
              </i>
            </li>
          </ul>
          <div class="c-flex--column u-w-100p">
            <div class="p-topic-modal__contents c-flex--column c-flex__ai-c c-flex--jc-c">
              <p>画像/記事引用URLを貼り付けてください</p>
                <input type="text" class="c-form__input c-form-w-100" v-on:input="updateUrl">
                <p class="text__c--red" v-show="this.error">
                URLを貼り付けてください
            </div>
            <div class="p-topic-modal__form c-flex c-flex__jc-end">
              <div class="c-btn c-btn--pink c-btn--md text--c" @click="submit">
                貼り付け
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </transition>
  `
})
