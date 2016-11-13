class Tab {
  constructor() {
    $("[data-tab]").click( (e) => {
      e.preventDefault();
      this.changeTab(e);
    });
  }

  changeTab(event) {
    this.clearContents()
    this.clearActive()
    const a = $(event.target).closest("a")
    a.addClass("is-active")
    this.showContent(a.data("tab"))
  }

  showContent(content) {
    $(`[data-home-tab-contents=${content}]`).show()
  }

  clearActive() {
    $("[data-tab]").each (function() {
      $(this).removeClass("is-active");
    });
  }

  clearContents() {
    $("[data-home-tab-contents]").each (function() {
      $(this).hide();
    });
  }
}

new Tab;
