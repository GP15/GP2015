// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootsy
//= require bootstrap
//= require imagesloaded.pkgd.min
//= require ion.rangeSlider.min
//= require moment.min
//= require jquery.isotope.min
//= require partners
//= require schedules
//= require google_analytics
//= require faq
//= require underscore
//= require jquery.bootstrap.wizard.min
//= require jquery.steps.min
//= require jquery_nested_form
//= require onboard
//= require add_child
//= require map
//= require gmaps/google
//= require animsition.min


$(document).ready(function()
{
  $(".animsition").animsition({
    inClass: 'fade-in',
    outClass: 'fade-out',
    inDuration: 1500,
    outDuration: 800,
    linkElement: '.animsition-link',
    // e.g. linkElement: 'a:not([target="_blank"]):not([href^="#"])'
    loading: true,
    loadingParentElement: 'body', //animsition wrapper element
    loadingClass: 'animsition-loading',
    loadingInner: '', // e.g '<img src="loading.svg" />'
    timeout: false,
    timeoutCountdown: 5000,
    onLoadEvent: true,
    browser: [ 'animation-duration', '-webkit-animation-duration'],
    // "browser" option allows you to disable the "animsition" in case the css property in the array is not supported by your browser.
    // The default setting is to disable the "animsition" in a browser that does not support "animation-duration".
    overlay : false,
    overlayClass : 'animsition-overlay-slide',
    overlayParentElement : 'body',
    transition: function(url){ window.location.href = url; }
  });

  var params = getSearchParameters();

  if(params.soon){
    $('#comingsoon').modal('show');
  }

  if(params.convert){
    $('#reward-popout').modal('show');
  }

  $('#top-get-started-btn').on('click', function(e){
    $.scrollTo("#top-request-zipcode-form");
    $('#top-request-zipcode-form').find('.btn').click();
  });
  $('.cta-partner').on('click', function(e){
    $.scrollTo("#bottom-request-zipcode-form");
  });

  $('.email-sign-up-btn').on('click', function(e){
    e.preventDefault();
    $(this).hide();
    $('.signup-form').removeClass('hide');
  });


  if($('.reward-readmore').length > 0){
    $('.reward-readmore').on('click', function(e){
      e.preventDefault();
      var text = $(this).attr('data-description');
      var title = $(this).attr('data-title');
      var point = $(this).attr('data-point');

      $('#reward-description').html(text);
      $('#reward-title').html("Redeem " + title + " with " + point + " points.")
      $('#reward-modal').modal('show');
    });
  }

  $(".alert").fadeTo(3000, 1500).slideUp(1500, function(){
    $(".alert").slideUp(1500);
  });

  var scrolled = 0;
  $('#right-scroll-btn').on('click', function(e){
    e.preventDefault();
    scrolled = scrolled + 55;
    $('#date-filter-choose').stop().animate({
        scrollLeft: scrolled
    });
    return false;
  });

});


function getSearchParameters() {
      var prmstr = window.location.search.substr(1);
      return prmstr != null && prmstr != "" ? transformToAssocArray(prmstr) : {};
}

function transformToAssocArray( prmstr ) {
    var params = {};
    var prmarr = prmstr.split("&");
    for ( var i = 0; i < prmarr.length; i++) {
        var tmparr = prmarr[i].split("=");
        params[tmparr[0]] = tmparr[1];
    }
    return params;
}


jQuery.scrollTo = function (target, offset, speed, container) {
    if (isNaN(target)) {

        if (!(target instanceof jQuery))
            target = $(target);

        target = parseInt(target.offset().top);
    }

    container = container || "html, body";
    if (!(container instanceof jQuery))
        container = $(container);

    speed = speed || 500;
    offset = offset || 0;

    container.animate({
        scrollTop: target + offset
    }, speed);
};