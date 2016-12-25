$("[data=icon-item]")
  .mouseover(function() {
    const $this = $(this);
    $this.find("[data=icon-description]").show();
  })
  .mouseout(function() {
    const $this = $(this);
    $this.find("[data=icon-description]").hide();
  });
