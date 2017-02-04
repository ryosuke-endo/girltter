import Vue from 'vue/dist/vue'
import iconData from '../../mixins/icon'

export default Vue.extend({
  mixins: [iconData],
  methods: {
    showModal() {
      this.$emit('show')
    }
  },
  template: `
    <div class="c-flex">
      <div class="c-form__file">
        <i class="fa fa-camera c-icon-d-gray c-margin-r-10 text--s-lg c-icon__item">
          <input accept="image/jpg,image/jpeg,image/png,image/gif" type="file" class="c-form__file__upload--icon" @click="showModal" @mouseenter="showCamera" @mouseleave="hiddenCamera">
          <div class="p-topic--icon__description text--s-sm text--c text--b" v-show="cameraActive">
              画像を投稿する
          </div>
        </i>
      </div>
      <div class="c-icon__items">
        <i data="icon-item" class="fa fa-link c-icon-d-gray c-margin-r-10 text--s-lg c-icon__item" @click="showModal" @mouseenter="showLink" @mouseleave="hiddenLink">
          <div class="p-topic--icon__description text--s-sm text--c text--b" v-show="linkActive">
            画像/記事を引用する
          </div>
        </i>
      </div>
    </div>`
})
