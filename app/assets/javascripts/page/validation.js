function submitAnswerFX(answerid, submission) {
  $(answerid).spin('small', 'blue');
  setTimeout(function() {
    $(answerid).spin(false);
  }, 1500 );
  function showAnswer() {
    $(answerid).css('color', 'green');
    $(answerid).text("Answer accepted: " + '"' + submission + '"');
    if (answerid == "#r1answered") {
      $("#r1playbutton").removeClass("hidden");
      $("#r2playbutton").removeClass("hidden");
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
