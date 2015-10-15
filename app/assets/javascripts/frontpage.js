/*!
 * Front page js by: Yiedpozi
 * yiedpozi@gmail.com
 */

;(function($) {
	'use strict'

	/**
	 * Slider - Features
	 */
	function sliderFeatures() {
		var $sliderImages = $('.slider-features-images'),
			$sliderContent = $('.slider-features-content');

		// Slider image option
		$sliderImages.slick({
			slidesToShow: 1,
			asNavFor: '.slider-features-content',
			arrows: false,
			dots: false,
			infinite: false
		});

		// Slider content option
		$sliderContent.slick({
			slidesToShow: 1,
			appendArrows: '.slider-features .slider-nav .slider-arrows',
			appendDots: '.slider-features .slider-nav .slider-dots',
			asNavFor: '.slider-features-images',
			arrows: true,
			dots: true,
			infinite: false,
			adaptiveHeight: true
		});
	}

	/**
	 * Maps - Location
	 */
	var map;
	function setupMap() {
		// If element exist
		if ($('#nearby-places').length) {
			// Create map
			var $map = new GMaps({
				div: '#nearby-places',
				lat: 37.6,
				lng: -95.665,
				zoom: 5,
				scrollwheel: false
			});

			// Add marker
			$map.addMarker({
				lat: 37.6,
				lng: -95.665,
				title: 'Title',
				infoWindow: {
					content: '<strong>Title</strong><p>Description</p>'
				},
				icon: 'map-marker.png'
			});
		}
	}

	/**
	 * Dropdown Select
	 */
	function formDropdownSelect() {
		$('.form-select-control').chosen({
			disable_search_threshold: 10,
			width: '100%'
		});
	}
	formDropdownSelect();

	/**
	 * Range Slider
	 */
	function formRangeSlider() {
		var $rangeSlider = $('.schedule-time-slider'),
			$startTimeHour = $('#q_start_time_gteq_4i'),
			$startTimeMinute = $('#q_start_time_gteq_5i'),
			$endTimeHour = $('#q_end_time_lteq_4i'),
			$endTimeMinute = $('#q_end_time_lteq_5i');

		// Create time slider
		$rangeSlider.ionRangeSlider({
			type: 'double',
			grid: false,
			force_edges: true,
			hide_min_max: true,
			min: +moment().set({'hour': 0, 'minute': 0, 'second': 0, 'millisecond': 0}).format("X"),
			max: +moment().set({'hour': 23, 'minute': 59, 'second': 59, 'millisecond': 59}).format("X"),
			from: +moment().set({'hour': 0, 'minute': 0, 'second': 0, 'millisecond': 0}).format("X"),
			to: +moment().set({'hour': 23, 'minute': 59, 'second': 59, 'millisecond': 59}).format("X"),
			step: 900, // 900 seconds = 15 minutes
			prettify: function(num) {
				// Format time
				return moment(num, "X").format("h:mm A");
			},
			onChange: function(value) {
				// Pass data value to input
				$startTimeHour.val(moment(value.from, "X").format("h"));
				$startTimeMinute.val(moment(value.from, "X").format("mm"));
				$endTimeHour.val(moment(value.to, "X").format("h"));
				$endTimeMinute.val(moment(value.to, "X").format("mm"));
			}
		});
	}

	/**
	 * Date Select
	 */
	function formDateSelect() {
		var $dateFilterChoose = $('#date-filter-choose li'),
			$dateFilterDropdown = $('#date-filter-dropdown'),
			$dateInput = $('#q_start_date_eq');

		// Update input value on click
		$dateFilterChoose.on('click', function() {
			var dateChoose = $(this).find('a').attr('data-date');
			$dateInput.val(dateChoose);
		});

		// Update input value on dropdown select
		$dateFilterDropdown.on('change', function(evt, params) {
			var dateDropdown = params.selected;
			$dateInput.val(dateDropdown);
		});
	}

	// DOM ready
	$(function() {
		setupMap();
		sliderFeatures();
		formRangeSlider();
		formDateSelect();
	});

})(jQuery);
