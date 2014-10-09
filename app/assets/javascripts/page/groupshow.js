emojify.run();
function scrollChat() {
  $("#chatbox").animate({ scrollTop: "10000px" }, 1200);
}
setTimeout(scrollChat, 150);

function checkChat() {
  function reloadChatbox() {
    var pathname = window.location.pathname;
    $("#chatboxcontent").load(pathname + " #chatboxcontent");
    emojify.run();
  }
  setTimeout(reloadChatbox, 150);

  function scrollChat() {
    $("#chatbox").scrollTop(10000);
    emojify.run();
  }
  setTimeout(scrollChat, 300);
}
setInterval(checkChat, 12000);


