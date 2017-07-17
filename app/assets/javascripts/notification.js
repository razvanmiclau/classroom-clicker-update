// Display Notifications
$(document).ready(function(){
  setTimeout(function(){
    $('.notice-container').fadeOut('slow', function() {
      $(this).remove();
    })
  }, 1500);
  $('#notice').hide();
});
