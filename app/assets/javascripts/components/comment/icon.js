import Vue from 'vue/dist/vue'

export default Vue.extend({
  data() {
    return {
      cameraActive: false,
      linkActive: false
    }
  },
  methods: {
    showCamera() {
      this.cameraActive = true
    },
    hiddenCamera() {
      this.cameraActive = false
    },
    showLink() {
      this.linkActive = true
    },
    hiddenLink() {
      this.linkActive = false
    },
    showModal() {
      this.$emit('show')
    }
  },
  template: `
    <div class="c-flex">
      <div class="c-form__file">
        <i class="fa fa-camera c-icon-d-gray c-margin-r-10 text--s-lg c-icon__item">
          <input accept="image/jpg,image/jpeg,image/png,image/gif" type="file" class="c-form__file__upload" @click="showModal" @mouseenter="showCamera" @mouseleave="hiddenCamera">
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
