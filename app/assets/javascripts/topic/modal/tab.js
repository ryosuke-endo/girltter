export default class {

  constructor() {
    this.$tab = $("[data=icon-item]")
  }

  addActive() {
    const list = this.$tab.attr('class').split(/\s/)
    const check_list = ["fa-link"]
    const target = list.filter((item) => {
      if ($.inArray(item, check_list) >= 0) {
        return item;
      }
    });
    switch(target[0]) {
      case "fa-link":
        $('[data-fa-link]').addClass('is-active')
        break;
    }
  }

}
