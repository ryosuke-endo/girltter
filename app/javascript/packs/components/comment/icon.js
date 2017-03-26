import Vue from 'vue/dist/vue'
import iconData from '../../mixins/icon'

const CONTENT_TYPE = [
  'image/jpg',
  'image/jpeg',
  'image/png',
  'image/gif',
  'image/bmp',
]
export default Vue.extend({
  mixins: [iconData],
  data() {
    return {
      reader: new FileReader()
    }
  },
  methods: {
    openModal() {
      this.$emit('open')
    },
    isContent(type, file) {
      return type.indexOf(file.type) !== -1
    },
    upload(e) {
      const file = e.target.files[0]
      if(this.isContent(CONTENT_TYPE, file)) {
        this.reader.readAsDataURL(file)
        this.reader.onload = (file) => {
          this.$emit('input', file.target.result)
        }
      }
    }
  },
  template: `
    <div class="c-flex">
      <div class="c-form__file">
        <i class="fa fa-camera c-icon-d-gray c-margin-r-10 text--s-lg c-icon__item">
          <input accept="image/jpg,image/jpeg,image/png,image/gif" type="file" class="c-form__file__upload--icon" @change="upload" @mouseenter="showCamera" @mouseleave="hiddenCamera">
          <div class="p-topic--icon__description text--s-sm text--c text--b" v-show="cameraActive">
              画像を投稿する
          </div>
        </i>
      </div>
      <div class="c-icon__items">
        <i class="fa fa-link c-icon-d-gray c-margin-r-10 text--s-lg c-icon__item" @click="openModal" @mouseenter="showLink" @mouseleave="hiddenLink">
          <div class="p-topic--icon__description text--s-sm text--c text--b" v-show="linkActive">
            画像/記事を引用する
          </div>
        </i>
      </div>
    </div>`
})
