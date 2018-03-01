---
layout: null
sitemap: false
---

function DynamicAlign() {
    var $window = $(window);
    var windowsize = $window.width();
    if (windowsize > 1000) {
        $('section.right-code > p.right-section-title').each(function () {
            var $right_item = $(this);
            // compute right side
            var $text = $right_item[0].innerHTML.toLowerCase().replace(/ /g, '-');
            var $section_id_name = $right_item.parent().parent()[0].id;
            var $right_position = $right_item.position().top - $right_item.parent().parent().offset().top;

            // compute left side & match difference
            var $left_item = $("#" + $section_id_name + " .left-docs" + " h3#" + $text);
            if ($left_item.length > 0) {
                var $left_parent = $left_item.parent().parent().offset().top;
                var $left_height = $left_item.position().top;
                var $left_position = $left_height - $left_parent;
                var $difference = Math.abs($left_position - $right_position);
                if ($left_position > $right_position) {
                  // Left item is further down the page; move the right item down to match
                  $right_item.css('margin-top', $difference + 8);
                } else {
                  // Right item is further down the page; move the left item down to match
                  $left_item.css('margin-top', $difference + 20);
                }
            }
        });
    }
};

window.onload = DynamicAlign;
window.onresize = DynamicAlign;
