import Vue from 'vue/dist/vue'

export default Vue.extend({
  methods: {
    closeModal() {
      this.$emit('close')
    }
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
            <li>
              <i class="fa fa-link c-icon-d-gray text--s-lg p-topic-modal__icon">
              </i>
            </li>
          </ul>
          <div class="c-flex--column">
            <div class="p-topic-modal__contents c-flex--column c-flex__ai-c c-flex--jc-c">
              <p>画像/記事引用URLを貼り付けてください</p>
                <input type="text" name="quote[url]" id="quote_url" value="" class="c-form__input c-form-w-100">
            </div>
            <div class="p-topic-modal__form c-flex c-flex__jc-end">
              <div class="c-btn c-btn--pink c-btn--md text--c">
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
