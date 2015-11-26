/* ---------------------------------------------
  FAQ page js by Yiedpozi
  yiedpozi@gmail.com
----------------------------------------------- */
;(function($) {
	'use strict'

	/**
	 * Smooth Scrolling
	 */
	function smoothScrolling() {
		var duration = 300;

		// Smooth scrolling on link click
		$("a[href^='#']").on('click', function(e) {
			e.preventDefault();
			var hash = this.hash;

			// Smooth scrolling
			$('html, body').animate({
				scrollTop: $(hash).offset().top
			}, duration, function() {
				// Add hash to url when done
				window.location.hash = hash;
			});
		});
	}

	// DOM ready
	$(function() {
		smoothScrolling();
	});
})(jQuery);
