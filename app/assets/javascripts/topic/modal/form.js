import URI from 'urijs'

export default class {
  constructor() {
    this.submit_error = true
  }

  getUrl() {
    return URI($('[data=modal-input]').val());
  }

  getInputText(){
    return $('textarea[name="topic[body]"]');
  }

  setSubmitError(bool) {
    return this.submit_error = bool
  }

  setDsiplayError() {
    return $('[data=modal-input]').
      after('<p class="text__c--red" data-modal-submit-error> URLを貼り付けてください')
  }

  isSubmitSuccess() {
    return this.submit_error === false
  }

  isDisplayError() {
    return !($('[data-modal-submit-error]').size())
  }

  removeDisplayError() {
    $('[data-modal-submit-error]').remove();
  }

  urlSubmit() {
    const url = this.getUrl();
    if(url.hostname().length !== 0) {
      this.addUrl(url);
      return this.setSubmitError(false);
    }

    this.setSubmitError(true);

    if(this.isDisplayError()) {
      this.setDsiplayError();
    }
  }

  addUrl(url) {
    const $inputText = this.getInputText();
    const $text = $inputText.val()

    if($text.length === 0) {
      $inputText.val(url);
    } else {
      $inputText.val(`${$text}\n\n${url}`);
    }
  }
}
