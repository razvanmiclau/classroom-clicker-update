// Custom SweetAlerts inspired from:
// http://lesseverything.com/blog/archives/2012/07/18/customizing-confirmation-dialog-in-rails/
// All rights reserved to the respective authors

$(document).ready(function(){
  // Provide inline validation to forms
  $('form').validate();
  // Activate Bootstrap Tooltips
  $('[data-toggle="tooltip"]').tooltip();
  // DELETE BUTTON - Replacing conventional alert with Sweetalert.js
    $.rails.allowAction = function(link) {
    if (!link.attr('data-confirm')) {
      return true;
    }
    $.rails.showConfirmDialog(link);
    return false;
  };

  $.rails.confirmed = function(link) {
    link.removeAttr('data-confirm');
    return link.trigger('click.rails');
  };

  $.rails.showConfirmDialog = function(link) {
    swal({
    title: 'Are you sure?',
    text: "You won't be able to revert this!",
    type: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Yes, delete it!',
    closeOnConfirm: false
  }).then(function(isConfirm) {
    if (isConfirm) {
      $.rails.confirmed(link)
    }
  })
  };
});
