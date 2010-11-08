$(document).ready( function () {
  console.log($('#tweeter'));
  $("#tweeter_text").charCount();
  $('#tweeter').bind('submit', function (e) {
    $('#tweeter_button').attr('disabled', true);
    $.post( '/twitter/post', { 'text' : $('#tweeter_text').val() }, function () {
      $("#tweeter").replaceWith('<p class="big">Thanks! We\'ve posted your tweet.</p>');
    });
    e.preventDefault();
  });
});
