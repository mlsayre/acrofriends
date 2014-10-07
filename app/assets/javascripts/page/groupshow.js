function scrollChat() {
  $("#chatbox").scrollTop(10000);
}
setTimeout(scrollChat, 150);

function checkChat() {
  var pathname = window.location.pathname;
  $("#chatboxcontent").load(pathname + " #chatboxcontent");
  function scrollChat() {
    $("#chatbox").scrollTop(10000);
  }
  setTimeout(scrollChat, 250);
}
setInterval(checkChat, 12000);


