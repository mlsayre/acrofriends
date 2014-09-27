var passbox = $("#pvtcheckbox");
var passenter = $("#grouppasswordcreate");
var passfield = $("#grouppasswordfield");

passenter.prop("disabled", true);
passfield.hide();

passbox.click(function(){
  passenter.prop("disabled",!passenter.prop("disabled"));
  passfield.toggle();
});

