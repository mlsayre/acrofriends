function scrollChat() {
  $("#chatbox").animate({ scrollTop: "10000px" }, 1200);
}
setTimeout(scrollChat, 150);

function checkChat() {
  var pathname = window.location.pathname;
  $("#chatboxcontent").load(pathname + " #chatboxcontent");

  function scrollChat() {
    $("#chatbox").animate({ scrollTop: "10000px" }, 2000);
  }
  setTimeout(scrollChat, 300);
}
setInterval(checkChat, 12000);


