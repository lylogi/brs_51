$(document).ready(function() {
  $('.comment_edit').click(function(){
    $(this).text($(this).text() == "Cancel" ? "Edit": "Cancel");
    $(this.nextElementSibling).toggle();
  });
});
