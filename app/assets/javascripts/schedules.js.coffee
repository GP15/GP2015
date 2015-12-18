### ---------------------------------------------
  Schedules page js by Yiedpozi
  yiedpozi@gmail.com
----------------------------------------------- 
###

(($) ->

  ###*
  # Dropdown Select
  ###

  # function formDropdownSelect() {
  # 	$('.form-select-control').chosen({
  # 		disable_search_threshold: 10,
  # 		width: '100%'
  # 	});
  # }
  # formDropdownSelect();

  ###*
  # Range Slider
  ###

  formRangeSlider = ->
    $rangeSlider = $('.schedule-time-slider')
    $startTime = $('#start_time')
    $endTime = $('#end_time')
    # Create time slider
    min = +moment().startOf('day').format('X')
    max = +moment().endOf('day').format('X')

    if $startTime.length && $endTime.length && ($startTime.val().length > 0) && ($endTime.val().length > 0)
      start = +moment($startTime.val(), 'h:mm:ss a').format('X')
      end = +moment($endTime.val(), 'h:mm:ss a').format('X')

    $rangeSlider.ionRangeSlider
      type: 'double'
      grid: false
      force_edges: true
      hide_min_max: true
      min: min
      max: max
      from: start
      to: end
      step: 900
      prettify: (num) ->
        # Format time
        moment(num, 'X').format 'h:mm A'
      onChange: (value) ->
        # Pass data value to input
        $startTime.val moment(value.from, 'X').format('h:mm:ss a')
        $endTime.val moment(value.to, 'X').format('h:mm:ss a')
        return
    return

  ###*
  # Date Select
  ###

  formDateSelect = ->
    $dateFilterChoose = $('#date-filter-choose li')
    $dateFilterDropdown = $('#date-filter-dropdown')
    $dateInput = $('#q_start_date_eq')
    # Update input value on click
    $dateFilterChoose.on 'click', ->
      dateChoose = $(this).find('a').attr('data-date')
      # Update input value
      $dateInput.val dateChoose
      # Add selected class
      $dateFilterChoose.removeClass 'selected'
      $(this).addClass 'selected'
      return
    # Update input value on dropdown select
    $dateFilterDropdown.on 'change', (evt, params) ->
      dateDropdown = params.selected
      $dateInput.val dateDropdown
      return
    return

  'use strict'
  # DOM ready
  $ ->
    formRangeSlider()
    formDateSelect()
    return
  return
) jQuery

# ---
# generated by js2coffee 2.1.0