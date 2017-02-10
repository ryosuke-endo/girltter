import URI from 'urijs'
import axios from 'axios/dist/axios'

export default class {
  constructor(e) {
    this.target = e.target
    this.no = this.target.textContent.replace(/\>/g, '')
    this.url = `${URI(location.href).path()}/comments/${this.no}/anchor`
  }

  send() {
    const self = this
    axios({
      method: "GET",
      url: this.url,
      timeout: 10000
    }).then(function(res) {
      self.showRes(res.data)
    }).catch(function(error) {
      const message = `
      <div id="p-anchor">
        <div class="p-anchor--container">
          タイムアウトしたため、コメントを取得できませんでした
        </div>
      </div>
      `
      self.showRes(message)
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
