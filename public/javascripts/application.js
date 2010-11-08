// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function mark_attending(uid, csid, time) {
  $.post( "/attendances", { "attendance[user_id]": uid, "attendance[conference_session_id]": csid }, function () { 
    $.get("/conference_sessions/for/" + time, function (data) {
      $("#timeslot_" + time).replaceWith( data );
    });
  });
}
