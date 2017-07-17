// Display Nested Form when Multiple-choice is selected
$('.questions.new').ready(function(){
    $('.selectpicker').change(function(){
      var selection = $(this).val();
      if(selection === 'Multiple-choice'){
        $('#custom_fields').fadeIn();
        $('input[type=text]').focus();
      } else {
        $('#custom_fields').fadeOut();
      };
    });
});
