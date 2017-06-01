function DynamicAlign() {
    $('section.right-code > p').each(function() {
        // compute right side
        var $text = $(this)[0].innerHTML.toLowerCase();
        var $right_position = $(this).position().top - $(this).parent().parent().offset().top;

        // compute left side & match difference
        var $left_item = $("#" + $text);
        if ($left_item) {
            var $left_parent = $left_item.parent().parent().offset().top;
            var $left_height = $left_item.position().top;
            var $left_position = $left_height - $left_parent;
            var $difference = Math.abs($left_position - $right_position);
            $left_item.css('margin-top', $difference);
        }
    });
};

window.onload = DynamicAlign;
window.onresize = DynamicAlign;





