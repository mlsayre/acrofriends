$("#mainplaygamesbutton").click(function () {
  $("#mainplayinggameslist").show();
  $("#mainvotinggameslist").hide();
  $("#mainresultsgameslist").hide();
});

$("#mainvotegamesbutton").click(function () {
  $("#mainplayinggameslist").hide();
  $("#mainvotinggameslist").show();
  $("#mainresultsgameslist").hide();
});

$("#maincompletedgamesbutton").click(function () {
  $("#mainplayinggameslist").hide();
  $("#mainvotinggameslist").hide();
  $("#mainresultsgameslist").show();
});
