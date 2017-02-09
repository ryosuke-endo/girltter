import URI from 'urijs'

export default class {
  constructor(e) {
    this.target = e.target
    this.no = this.target.textContent.replace(/\>/g, '')
    this.url = `${URI(location.href).path()}/comments/${this.no}/anchor`
  }

  send() {
    const self = this
    $.ajax({
      type: "GET",
      url: this.url
    }).done(function(res) {
      self.showRes(res)
    }).fail(function(res) {
      self.showRes(res.responseText)
    })
  }

  showRes(res) {
    const self = this.target
    $(self).after(res)
    $(self).addClass('is-disable')
    $('#p-anchor').on('mouseleave', function() {
      this.remove()
      $(self).removeClass('is-disable')
    })
  }
}
