function submitAnswerFX(answerid, submission) {
  $(answerid).spin('small', 'blue');
  setTimeout(function() {
    $(answerid).spin(false);
  }, 1500 );
  function showAnswer() {
    $(answerid).css('color', 'green');
    $(answerid).text("Answer accepted: " + '"' + submission + '"');
    if (answerid == "#r1answered") {
      $(".r1playbutton").addClass("roundplayanswered", 600, "easeOutBounce" );
      $(".r2playbutton").addClass("animated flip");
      $(".r2playbutton").removeClass("roundplaylocked");
      // $(".r2playbutton").text("Next Round");
    }
    else if (answerid == "#r2answered") {
      $(".r2playbutton").addClass("roundplayanswered", 600, "easeOutBounce" );
      $(".r3playbutton").addClass("animated flip");
      $(".r3playbutton").removeClass("roundplaylocked");
      // $(".r3playbutton").text("Next Round");
    }
    else if (answerid == "#r3answered") {
      $(".r3playbutton").addClass("roundplayanswered", 600, "easeOutBounce" );
      $(".r4playbutton").addClass("animated flip");
      $(".r4playbutton").removeClass("roundplaylocked");
      // $(".r4playbutton").text("Next Round");
    }
    else if (answerid == "#r4answered") {
      $(".r4playbutton").addClass("roundplayanswered", 600, "easeOutBounce" );
      $(".r5playbutton").addClass("animated flip");
      $(".r5playbutton").removeClass("roundplaylocked");
      // $(".r5playbutton").text("Next Round");
    }
    else if (answerid == "#r4answeredshortgame") {
      $(".r4playbutton").addClass("roundplayanswered", 600, "easeOutBounce" );
      $(".allanswered").removeClass("hidden");
      $(".allanswered").addClass("animated bounce");
    }
    else if (answerid == "#r5answered") {
      $(".r5playbutton").addClass("roundplayanswered", 600, "easeOutBounce" );
      $(".r6playbutton").addClass("animated flip");
      $(".r6playbutton").removeClass("roundplaylocked");
      // $(".r6playbutton").text("Next Round");
    }
    else if (answerid == "#r6answered") {
      $(".r6playbutton").addClass("roundplayanswered", 600, "easeOutBounce" );
      $(".r7playbutton").addClass("animated flip");
      $(".r7playbutton").removeClass("roundplaylocked");
      // $(".r7playbutton").text("Next Round");
    }
    else if (answerid == "#r7answered") {
      $(".r7playbutton").addClass("roundplayanswered", 600, "easeOutBounce" );
      $(".r8playbutton").addClass("animated flip");
      $(".r8playbutton").removeClass("roundplaylocked");
      // $(".r8playbutton").text("Next Round");
    }
    else if (answerid == "#r8answered") {
      $(".r8playbutton").addClass("roundplayanswered", 600, "easeOutBounce" );
      $(".allanswered").removeClass("hidden");
      $(".allanswered").addClass("animated bounce");
    }
  }
  setTimeout(showAnswer, 1300);
}

function notAnAcronym(answerid) {
  $(answerid).css('color', 'red');
  $(answerid).text("Not an acronym!");
}

function incorrectLength(answerid) {
  $(answerid).css('color', 'red');
  $(answerid).text("Incorrect length!");
}

function notJustLetters(answerid) {
  $(answerid).css('color', 'red');
  $(answerid).text("Not feeling creative?");
}

// acronym validation
function acroValidate(roundletters, answerid, answerform, answerfield) {
  var letters = roundletters;
  var eachletter = letters.split('');
  var submission = document.getElementById(answerfield).value;
  var words = submission.toUpperCase().match(/(?!")\S+/g);
  console.log(letters);
  if (submission.replace(/\s{2,}/g, '') == "") {
    notJustLetters(answerid);
    return false;
  };
  if (eachletter.length == 3) {
    if (words.length == 3 &&
       ((words[0].charAt(0) != eachletter[0]) ||
       (words[1].charAt(0) != eachletter[1]) ||
       (words[2].charAt(0) != eachletter[2])))
      {
        notAnAcronym(answerid);
        return false;
      }
    else if ((words.length < 3) || (words.length > 3))
      {
        incorrectLength(answerid);
        return false;
      }
    else if (words.length == 3 &&
       ((words[0] == eachletter[0]) &&
       (words[1] == eachletter[1]) &&
       (words[2] == eachletter[2])))
      {
        notJustLetters(answerid);
        return false;
      }
      else {
        submitAnswerFX(answerid, submission);
        return( true );
      }
  }
  else if (eachletter.length == 4) {
    if (words.length == 4 &&
       ((words[0].charAt(0) != eachletter[0]) ||
       (words[1].charAt(0) != eachletter[1]) ||
       (words[2].charAt(0) != eachletter[2]) ||
       (words[3].charAt(0) != eachletter[3])))
      {
        notAnAcronym(answerid);
        return false;
      }
    else if ((words.length < 4) || (words.length > 4))
      {
        incorrectLength(answerid);
        return false;
      }
    else if (words.length == 4 &&
       ((words[0] == eachletter[0]) &&
       (words[1] == eachletter[1]) &&
       (words[2] == eachletter[2]) &&
       (words[3] == eachletter[3])))
      {
        notJustLetters();
        return false;
      }
      else {
        submitAnswerFX(answerid, submission);
        return( true );
      }
    }
    else if (eachletter.length == 5) {
      if (words.length == 5 &&
         ((words[0].charAt(0) != eachletter[0]) ||
         (words[1].charAt(0) != eachletter[1]) ||
         (words[2].charAt(0) != eachletter[2]) ||
         (words[3].charAt(0) != eachletter[3]) ||
         (words[4].charAt(0) != eachletter[4])))
        {
          notAnAcronym(answerid);
          return false;
        }
      else if ((words.length < 5) || (words.length > 5))
        {
          incorrectLength(answerid);
          return false;
        }
      else if (words.length == 5 &&
         ((words[0] == eachletter[0]) &&
         (words[1] == eachletter[1]) &&
         (words[2] == eachletter[2]) &&
         (words[3] == eachletter[3]) &&
         (words[4] == eachletter[4])))
        {
          notJustLetters(answerid);
          return false;
        }
        else {
          submitAnswerFX(answerid, submission);
          return( true );
        }
    }
    else if (eachletter.length == 6) {
      if (words.length == 6 &&
         ((words[0].charAt(0) != eachletter[0]) ||
         (words[1].charAt(0) != eachletter[1]) ||
         (words[2].charAt(0) != eachletter[2]) ||
         (words[3].charAt(0) != eachletter[3]) ||
         (words[4].charAt(0) != eachletter[4]) ||
         (words[5].charAt(0) != eachletter[5])))
        {
          notAnAcronym(answerid);
          return false;
        }
      else if ((words.length < 6) || (words.length > 6))
        {
          incorrectLength(answerid);
          return false;
        }
      else if (words.length == 6 &&
         ((words[0] == eachletter[0]) &&
         (words[1] == eachletter[1]) &&
         (words[2] == eachletter[2]) &&
         (words[3] == eachletter[3]) &&
         (words[4] == eachletter[4]) &&
         (words[5] == eachletter[5])))
        {
          notJustLetters(answerid);
          return false;
        }
        else {
          submitAnswerFX(answerid, submission);
          return( true );
        }
    }
    else if (eachletter.length == 7) {
      if (words.length == 7 &&
         ((words[0].charAt(0) != eachletter[0]) ||
         (words[1].charAt(0) != eachletter[1]) ||
         (words[2].charAt(0) != eachletter[2]) ||
         (words[3].charAt(0) != eachletter[3]) ||
         (words[4].charAt(0) != eachletter[4]) ||
         (words[5].charAt(0) != eachletter[5]) ||
         (words[6].charAt(0) != eachletter[6])))
        {
          notAnAcronym(answerid);
          return false;
        }
      else if ((words.length < 7) || (words.length > 7))
        {
          incorrectLength(answerid);
          return false;
        }
      else if (words.length == 7 &&
         ((words[0] == eachletter[0]) &&
         (words[1] == eachletter[1]) &&
         (words[2] == eachletter[2]) &&
         (words[3] == eachletter[3]) &&
         (words[4] == eachletter[4]) &&
         (words[5] == eachletter[5]) &&
         (words[6] == eachletter[6])))
        {
          notJustLetters(answerid);
          return false;
        }
        else {
          submitAnswerFX(answerid, submission);
          return( true );
        }
    }
}
