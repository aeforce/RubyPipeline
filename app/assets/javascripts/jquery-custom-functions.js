(function ($) {
    $(document).ready(function () {
        $('a').click(function (e) {
            if ($(this).attr("disabled")) {
                return false;
            }
        });
    });
}(jQuery));
