import Vue from 'vue/dist/vue'
import iconData from '../../../mixins/icon'

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
  },
  template: `
    <div class="c-icon__items c-margin-l-10">
      <i data="icon-item" class="fa fa-link c-icon-d-gray c-margin-r-10 text--s-lg c-icon__item" @click="openModal">
      </i>
    </div>`
})
