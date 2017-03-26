export default {
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
    }
  }
}
