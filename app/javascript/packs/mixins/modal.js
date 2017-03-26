export default {
  data() {
    return {
      modalActive: false
    }
  },
  methods: {
    openModal() {
      this.modalActive = true;
      this.scrollFix();
    },
    closeModal() {
      this.modalActive = false;
      this.releaseFix();
    },
    scrollFix() {
      $('body').addClass('p-topic-modal-is-overflow-hidden')
    },
    releaseFix() {
      $('body').removeClass('p-topic-modal-is-overflow-hidden');
    }
  }
}
