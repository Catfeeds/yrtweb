(function ($) {
    $.fn.extend({
        textAreaCount: function (options) {
            var $textArea = this;
            options = $.extend({
                maxlength: 140,
                speed: 15,
                msgstyle: "font-family:Arial;font-size:small;color:Gray;small;text-align:left;margin-top:3px;",
                msgNumStyle: "font-weight:bold;color:Gray;font-style:italic;font-size:larger;" 
            }, options);
            var $msg = $("<div style='" + options.msgstyle + "'></div>");
          
            $textArea.after($msg);
           
            $textArea.keypress(function (e) {
               
                if ($textArea.val().length >= options.maxlength && e.which != '8' && e.which != '46') {
                    e.preventDefault();
                    return;
                }
            }).keyup(function () { 
                var curlength = this.value.length;
                $msg.html("").html("还能输入<span style='" + options.msgNumStyle + "'>" + (options.maxlength - curlength) + "</span> 字");
                var init = setInterval(function () {
                   
                    if ($textArea.val().length > options.maxlength) {
                        $textArea.val($textArea.val().substring(0, options.maxlength));
                        $msg.html("").html("还能输入<span style='" + options.msgNumStyle + "'>" + options.maxlength + "</span> 字");
                    }
                    else {
                        clearInterval(init);
                    }
                }, options.speed);
            }).bind("contextmenu", function (e) { 
                return false;
            });
           
            $msg.html("").html("还能输入<span style='" + options.msgNumStyle + "'>" + options.maxlength + "</span> 字");
            return this;
        }
    });
})(jQuery);