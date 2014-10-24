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

// validation
$("#r1answerform").submit(function() {
  var letters = $("#round1letters").text()
  return acroValidate(letters, "#r1answered", "r1answerform", "r1answerfield");
});

$("#r2answerform").submit(function() {
  var letters = $("#round2letters").text()
  return acroValidate(letters, "#r2answered", "r2answerform", "r2answerfield");
});

$("#r3answerform").submit(function() {
  var letters = $("#round3letters").text()
  return acroValidate(letters, "#r3answered", "r3answerform", "r3answerfield");
});

$("#r4answerform").submit(function() {
  var letters = $("#round4letters").text()
  return acroValidate(letters, "#r4answered", "r4answerform", "r4answerfield");
});

// voting round
$("#r1votebutton").click(function () {
  $("#r1vote").show();
  $("#r2vote").hide();
  $("#r3vote").hide();
  $("#r4vote").hide();
});
$("#r2votebutton").click(function () {
  $("#r1vote").hide();
  $("#r2vote").show();
  $("#r3vote").hide();
  $("#r4vote").hide();
});
$("#r3votebutton").click(function () {
  $("#r1vote").hide();
  $("#r2vote").hide();
  $("#r3vote").show();
  $("#r4vote").hide();
});
$("#r4votebutton").click(function () {
  $("#r1vote").hide();
  $("#r2vote").hide();
  $("#r3vote").hide();
  $("#r4vote").show();
});
$(".votebuttons").click(function() {
  $(".answervotedfor").spin('small', 'blue');
  function disableVoteButtons() {
    $(".votebuttons").prop("disabled", true);
  }
  setTimeout(disableVoteButtons, 700);
  function reenableVoteButtons() {
    var pathname = window.location.pathname;
    $("#r1votedfor").load(pathname + " #r1votedfor");
    $("#r2votedfor").load(pathname + " #r2votedfor");
    $("#r3votedfor").load(pathname + " #r3votedfor");
    $("#r4votedfor").load(pathname + " #r4votedfor");
  }
  setTimeout(reenableVoteButtons, 1500);
  function stopSpin() {
    $(".votebuttons").prop("disabled", false);
    $(".answervotedfor").spin(false);
  }
  setTimeout(stopSpin, 1800);
})
