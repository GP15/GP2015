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
//= require gmaps/google



$(document).ready(function()
{
  var params = getSearchParameters();

  if(params.soon){
    $('#comingsoon').modal('show');
  }

  $('#top-get-started-btn').on('click', function(e){
    $.scrollTo("#top-request-zipcode-form");
  });
  $('.cta-partner').on('click', function(e){
    $.scrollTo("#bottom-request-zipcode-form");
  });

  $('.email-sign-up-btn').on('click', function(e){
    e.preventDefault();
    $(this).hide();
    $('.signup-form').removeClass('hide');
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