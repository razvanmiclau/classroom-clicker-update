// Append choice value to the hidden input field for answer submission
$(document).ready(function(){
    $('#choices-form input[type=submit]').on('click', function(){
      var button_value = $(this).val();
      $('#choices-form input[type=text]').val(button_value);
    });
    $('#binary-choice-form input[type=submit]').on('click', function(){
      var button_value = $(this).val();
      $('#binary-choice-form input[type=text]').val(button_value);
    });
});
