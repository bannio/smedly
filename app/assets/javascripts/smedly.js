$(document).on('page:update', function() {
$("input.date_picker").datepicker({
        dateFormat: "yy-mm-dd",
        changeMonth: true,
        changeYear: true
      });
});
