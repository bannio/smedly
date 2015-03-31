$(document).on("page:change", function() {
    $('#extract-button').on("click", function(e) {
        e.preventDefault();
        $('#hoottweet-form').submit();
        setTimeout(function() {
            location.reload(true);
          },100);      
    });
});