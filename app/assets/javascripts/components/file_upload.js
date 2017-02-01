import Vue from 'vue/dist/vue'

const CONTENT_TYPE = [
  'image/jpg',
  'image/jpeg',
  'image/png',
  'image/gif',
  'image/bmp',
]
export default Vue.extend({
  props: {
    reader: {
      type: FileReader,
      default: function() {
        return new FileReader()
      }
    }
  },
  methods: {
    isContent: function(type, file) {
      return type.indexOf(file.type) !== -1
    },
    onFileChange: function(e) {
      const file = e.target.files[0]
      if(this.isContent(CONTENT_TYPE, file)) {
        this.previewImage(file)
      }
    },
    previewImage: function(file) {
      this.reader.readAsDataURL(file)
      this.reader.onload = (file) => {
        this.$emit('upload', file.target.result)
      }
    }
  },
  template: `<div class="c-btn__container">
               <div class="c-form__file c-border">
                 <i class="fa fa-camera c-icon-d-gray c-margin-r-10 text--s-lg">
                 </i>
                 <label>
                   画像を選択する
                   <input accept="image/jpg,image/jpeg,image/png,image/gif" type="file" class="c-form__file__upload" @change="onFileChange">
                 </label>
               </div>
             </div>`
})
