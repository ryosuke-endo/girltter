import Modal from './modal'

$("[data=icon-item]")
  .mouseenter(function() {
    const $this = $(this);
    $this.find("[data=icon-description]").show();
  })
  .mouseleave(function(){
    const $this = $(this);
    $this.find("[data=icon-description]").hide();
  });

$("[data=icon-item]").click(function() {
  const modal = new Modal(this, false)
  modal.open()
});
