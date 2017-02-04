import Vue from 'vue/dist/vue'

export default Vue.extend({
  data() {
    return {
      linkActive: false
    }
  },
  methods: {
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
    <div class="c-icon__items">
      <i data="icon-item" class="fa fa-link c-icon-d-gray c-margin-r-10 text--s-lg c-icon__item" @click="showModal" @mouseenter="showLink" @mouseleave="hiddenLink">
        <div class="p-topic--icon__description text--s-sm text--c text--b" v-show="linkActive">
          画像/記事を引用する
        </div>
      </i>
    </div>`
})
