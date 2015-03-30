
counter = function() {
    var value = $('#post_content').val();

    if (value.length == 0) {
        $('#charCount').html(0);
        return;
    }

    var totalChars = value.length;
    $('#charCount').html(totalChars);
    $('#charCount').css( "color", "black" );
    if (totalChars >= 94) {
      $('#charCount').css( "color", "orange" );  
    }
    if (totalChars >= 117) {
      $('#charCount').css( "color", "red" );  
    }
};

$(document).on("page:update", function() {
    $('#post_content').on("change", counter);
    $('#post_content').keydown(counter);
    $('#post_content').keypress(counter);
    $('#post_content').keyup(counter);
    $('#post_content').blur(counter);
    $('#post_content').focus(counter);
});