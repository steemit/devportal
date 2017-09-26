
function DynamicAlign() {
    var $window = $(window);
    var windowsize = $window.width();
    if (windowsize > 1000) {
        $('section.right-code > p.right-section-title').each(function () {
            // compute right side
            var $text = $(this)[0].innerHTML.toLowerCase();
            var $section_id_name = $(this).parent().parent()[0].id;
            var $right_position = $(this).position().top - $(this).parent().parent().offset().top;

            // compute left side & match difference
            var $left_item = $("#" + $section_id_name + " .left-docs" + " h3#" + $text);
            console.log($left_item);
            if ($left_item) {
                var $left_parent = $left_item.parent().parent().offset().top;
                console.log($left_parent)
                var $left_height = $left_item.position().top;
                var $left_position = $left_height - $left_parent;
                var $difference = Math.abs($left_position - $right_position);
                $left_item.css('margin-top', $difference);
            }
        });
    }
};

window.onload = DynamicAlign;
window.onresize = DynamicAlign;





