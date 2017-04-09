import Vue from 'vue/dist/vue'

const CONTENT_TYPE = [
  'image/jpg',
  'image/jpeg',
  'image/png',
  'image/gif',
  'image/bmp',
]

export default Vue.extend({
  data() {
    return {
      reader: new FileReader()
    }
  },
  methods: {
    isContent(type, file) {
      return type.indexOf(file.type) !== -1
    },
    onFileChange(e) {
      const file = e.target.files[0]
      if(this.isContent(CONTENT_TYPE, file)) {
        this.previewImage(file)
      }
    },
    previewImage(file) {
      this.reader.readAsDataURL(file)
      this.reader.onload = (file) => {
        this.$emit('input', file.target.result)
      }
    }
  },
  template: `<div class="c-btn__container">
               <div class="c-form__file c-border text--c">
                 <i class="fa fa-camera c-icon-d-gray text--s-lg">
                 </i>
                 <input accept="image/jpg,image/jpeg,image/png,image/gif" type="file" class="c-form__file__upload" @change="onFileChange">
               </div>
             </div>`
})
