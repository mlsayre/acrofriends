$("#r1playbutton").click(function () {
  $("#r1play").show();
  $("#r2play").hide();
  $("#r3play").hide();
  $("#r4play").hide();
});
$("#r2playbutton").click(function () {
  $("#r1play").hide();
  $("#r2play").show();
  $("#r3play").hide();
  $("#r4play").hide();
});
$("#r3playbutton").click(function () {
  $("#r1play").hide();
  $("#r2play").hide();
  $("#r3play").show();
  $("#r4play").hide();
});
$("#r4playbutton").click(function () {
  $("#r1play").hide();
  $("#r2play").hide();
  $("#r3play").hide();
  $("#r4play").show();
});
