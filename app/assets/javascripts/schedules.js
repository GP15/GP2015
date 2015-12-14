/* ---------------------------------------------
  Schedules page js by Yiedpozi
  yiedpozi@gmail.com
----------------------------------------------- */
;(function($) {
	'use strict'

	/**
	 * Dropdown Select
	 */
	// function formDropdownSelect() {
	// 	$('.form-select-control').chosen({
	// 		disable_search_threshold: 10,
	// 		width: '100%'
	// 	});
	// }
	// formDropdownSelect();

	/**
	 * Range Slider
	 */
	function formRangeSlider() {
		var $rangeSlider = $('.schedule-time-slider'),
			$startTime = $('#q__starts_at_gteq_'),
			$endTime = $('#q__ends_at_lteq_');
			

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
				$startTime.val(moment(value.from, "X").format("h") + ":" +moment(value.from, "X").format("mm"));
				$endTimeHour.val(moment(value.to, "X").format("h") + ":" +moment(value.to, "X").format("mm"));
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

			// Update input value
			$dateInput.val(dateChoose);

			// Add selected class
			$dateFilterChoose.removeClass('selected');
			$(this).addClass('selected');
		});

		// Update input value on dropdown select
		$dateFilterDropdown.on('change', function(evt, params) {
			var dateDropdown = params.selected;
			$dateInput.val(dateDropdown);
		});
	}

	// DOM ready
	$(function() {
		formRangeSlider();
		formDateSelect();
	});
})(jQuery);
