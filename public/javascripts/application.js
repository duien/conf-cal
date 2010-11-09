// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function mark_attending(uid, csid, time, url) {
  $.post( "/attendances", { "attendance[user_id]": uid, "attendance[conference_session_id]": csid }, function () { 
    if(url){
      window.location.replace(url);
    }else{
      $.get("/conference_sessions/for/" + time, function (data) {
        $("#timeslot_" + time).replaceWith( data );
      });
    }
  });
}

function mark_not_attending(aid, time, url) {
  $.post( "/attendances/" + aid, { "_method": 'DELETE' }, function () { 
    if(url){
      window.location.replace(url);
    }else{
      $.get("/conference_sessions/for/" + time, function (data) {
        $("#timeslot_" + time).replaceWith( data );
      });
    }
  });
}

$().ready(function() {
  $('.summary a')
    .bind('ajax:before', function(el) {
      var desc = $(el.target).parents('.option').find('.description:visible');
      if (desc.length > 0) {
        desc.slideUp();
        return false;
      }
    });
});
