// upon room entry
$(".answerfield").val("");

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

var pathname = window.location.pathname;
  $("#r1answer").click(function () {
    $("#r1answered").spin('small', 'blue');
    setTimeout(function() {
      $("#r1answered").spin(false);
    }, 2200 );
    function reloadR1Answer() {
      $(".answerfield").val("");
      $("#r1answered").load(pathname + " #r1answered");
    }
    setTimeout(reloadR1Answer, 2000);
  });
