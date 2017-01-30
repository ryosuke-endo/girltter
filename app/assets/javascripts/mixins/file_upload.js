export default {
  methods: {
    isContent: function(type, file) {
      return type.indexOf(file.type) !== -1
    }
  }
}
