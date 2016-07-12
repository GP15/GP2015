/* ---------------------------------------------
  Schedules page js by Yiedpozi
  yiedpozi@gmail.com
-----------------------------------------------
 */
(function($) {

  /**
   * Dropdown Select
   */

  /**
   * Range Slider
   */
  var formDateSelect, formRangeSlider;
  formRangeSlider = function() {
    var $endTime, $rangeSlider, $startTime, end, max, min, start;
    $rangeSlider = $('.schedule-time-slider');
    $startTime = $('#start_time');
    $endTime = $('#end_time');
    min = +moment().startOf('day').format('X');
    max = +moment().endOf('day').format('X');
    if ($startTime.length && $endTime.length && ($startTime.val().length > 0) && ($endTime.val().length > 0)) {
      start = +moment($startTime.val(), 'h:mm:ss a').format('X');
      end = +moment($endTime.val(), 'h:mm:ss a').format('X');
    }
    $rangeSlider.ionRangeSlider({
      type: 'double',
      step: 3600,
      grid: false,
      force_edges: true,
      hide_min_max: true,
      min: min,
      max: max,
      from: start,
      to: end,
      prettify: function(num) {
        return moment(num, 'X').format('h:mm A');
      },
      onChange: function(value) {
        $startTime.val(moment(value.from, 'X').format('h:mm:ss a'));
        $endTime.val(moment(value.to, 'X').format('h:mm:ss a'));
      }
    });
  };

  /**
   * Date Select
   */
  formDateSelect = function() {
    var $dateFilter, $dateFilterChoose, $dateFilterDropdown, $dateInput;
    $dateFilter = $('#date-filter-choose');
    $dateFilter.on('click', function() {
      return $(".filter-submit-btn").click();
    });
    $dateFilterChoose = $('#date-filter-choose li');
    $dateFilterDropdown = $('#date-filter-dropdown');
    $dateInput = $('#q_start_date_eq');
    $dateFilterChoose.on('click', function() {
      var dateChoose;
      dateChoose = $(this).find('a').attr('data-date');
      $dateInput.val(dateChoose);
      $dateFilterChoose.removeClass('selected');
      $(this).addClass('selected');
    });
    $dateFilterDropdown.on('change', function(evt, params) {
      var dateDropdown;
      dateDropdown = params.selected;
      $dateInput.val(dateDropdown);
    });
  };
  'use strict';
  $(function() {
    formRangeSlider();
    formDateSelect();
  });
})(jQuery);

// ---