import URI from 'urijs'

export default class {
  constructor() {
    this.error = true
  }

  submit() {
    const url = URI($('[data=modal-input]').val())
    if(url.hostname().length !== 0) {
      const $text = $('textarea[name="topic[body]"]')
      this.addUrl($text, url)
      return this.error = false
    }

    if($('[data-modal-submit-error]').size()) {
      console.log("false")
    } else {
      $('[data=modal-input]').
        after('<p class="text__c--red" data-modal-submit-error> URLを貼り付けてください')
    }
  }

  addUrl($text, url) {
    const $getText = $text.val()
    if($text.val().length === 0) {
      $text.val($getText + url);
    } else {
      $text.val($getText + '\n\n' + url);
    }
  }

  isSuccess() {
    return this.error === false
  }
}
