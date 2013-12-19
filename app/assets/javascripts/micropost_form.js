/**
 * Created by Ivan on 19/12/13.
 */



var countDown = function(){
        var  remain= 140-$("#micropost_content").val().length,
            output=$("#character_count_down");



        output.text(remain + " characters remaining");
        if (remain <=0) {
            output.css("color", "red");
        }
};


$(document).ready(function(){
    $("#micropost_content").keyup(countDown);
});

