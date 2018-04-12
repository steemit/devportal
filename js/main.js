jQuery(function() {
	var $sidebar = $('#sidebar'),
		$nav = $('.nav'),
		$main = $('.main');

	var found = true;

	var $el;

	$("section > div.highlighter-rouge:first-of-type").each(function(i) {

		var $this = $(this).before("<ul class=\"languages\"></ul>"),
		$languages = $this.prev(),
		$notFirst = $this.nextUntil(":not(div.highlighter-rouge)"),
		$all = $this.add($notFirst);

		$all.add($languages).wrapAll("<div class=\"code-viewer\"></div>");


		listLanguages($all, $languages);

		$this.css('display', 'block');

		$languages.find('a').first().addClass('active');

		$languages.find('a').click(function() {
			$all.css('display', 'none');
			$all.eq($(this).parent().index()).css('display', 'block');

			$languages.find('a').removeClass('active');
			$(this).addClass('active');
			return false;
		});

		if ($languages.children().length === 0) {
			$languages.remove();
		}
	});

	function listLanguages($el, $insert) {
		$el.each(function(i) {
			var title = $(this).attr('title');
			if (title) {
				$insert.append("<li><a href=\"#\">" + title + "</a></li>");
			}
		});
	}

	var href = $('.sidebar a').first().attr("href");

	if (href !== undefined && href.charAt(0) === "#") {
		setActiveSidebarLink();

		$(window).on("scroll", function(evt) {
			setActiveSidebarLink();
		});
	}

	function setActiveSidebarLink() {
			$('.sidebar a').removeClass('active');
				var $closest = getClosestHeader();
				$closest.addClass('active');
				document.title = $closest.text();

	}
});

function getClosestHeader() {
	var $links = $('.sidebar a'),
	top = window.scrollY,
	$last = $links.first();

	if (top < 300) {
		return $last;
	}

	if (top + window.innerHeight >= $(".main").height()) {
		return $links.last();
	}

	for (var i = 0; i < $links.length; i++) {
		var $link = $links.eq(i),
		href = $link.attr("href");

		if (href !== undefined && href.charAt(0) === "#" && href.length > 1) {
			var $anchor = $(href);

			if ($anchor.length > 0) {
				var offset = $anchor.offset();

				if (top < offset.top - 300) {
					return $last;
				}

				$last = $link;
			}
		}
	}
	return $last;
}



 $(document).ready(function(){
    // Select all links with hashes
    $('a[href*="#"]')
      // Remove links that don't actually link to anything
      .not('[href="#"]')
      .not('[href="#0"]')
      .click(function(event) {
        // On-page links
        if (
          location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') 
          && 
          location.hostname == this.hostname
        ) {
          // Figure out element to scroll to
          var target = $(this.hash);
          target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
          // Does a scroll target exist?
          if (target.length) {
            // Only prevent default if animation is actually gonna happen
            event.preventDefault();
            $('html, body').animate({
              scrollTop: target.offset().top
            }, 300, function() {
              // Callback after animation
              // Must change focus!
              var $target = $(target);
              $target.focus();
              if ($target.is(":focus")) { // Checking if the target was focused
                return false;
              } else {
                $target.attr('tabindex','-1'); // Adding tabindex for elements not focusable
                $target.focus(); // Set focus again
              };
            });
          }
        }
      });
        var acc = document.getElementsByClassName("accordion");
        var i;

        for (i = 0; i < acc.length; i++) {
            acc[i].addEventListener("click", function() {
                /* Toggle between adding and removing the "active" class,
                to highlight the button that controls the panel */
                this.classList.toggle("active");

                /* Toggle between hiding and showing the active panel */
                var panel = this.nextElementSibling;
                if (panel.style.display === "block") {
                    panel.style.display = "none";
                } else {
                    panel.style.display = "block";
                }
            });
        }
        acc[0].click();
        var clickedQ, clickedS, clickedC  = false;

        $(window).scroll(function (event) {
            var scroll = $(window).scrollTop();
            var quickS = $('#quickstart-choose-library').offset().top;
            var services = $('#services-steemit').offset().top;
            var communityO = $('#community-overview').offset().top;
            
            if (scroll > quickS && !clickedQ) {
                clickedQ = true;
                acc[0].click();
                acc[1].click();
            }
            if (scroll > services && !clickedS) {
                clickedS = true;
                acc[3].click();
                acc[1].click();
            }
             if (scroll > communityO && !clickedC) {
                clickedC = true;
                acc[5].click();
                acc[3].click();
            }
        });
    });
