$(document).ready(function() {

  if($('.partner-grid').length > 0){

    var special = jQuery.event.special,
        uid1 = 'D' + (+new Date()),
        uid2 = 'D' + (+new Date() + 1);

    special.scrollstop = {
        latency: 300,
        setup: function() {

            var timer,
                handler = function(evt) {

                    var _self = this,
                        _args = arguments;

                    if (timer) {
                        clearTimeout(timer);
                    }

                    timer = setTimeout( function(){

                        timer = null;
                        evt.type = 'scrollstop';

                        var wintop = $(window).scrollTop(), docheight = $(document).height(), winheight = $(window).height();
                        var  scrolltrigger = 0.80;

                        if  ((wintop/(docheight-winheight)) > scrolltrigger) {
                          lastAddedLiveFunc();
                        }

                    }, special.scrollstop.latency);

                };

            jQuery(this).bind('scroll', handler).data(uid2, handler);

        },
        teardown: function() {
            jQuery(this).unbind( 'scroll', jQuery(this).data(uid2) );
        }
    };


    partner_load_count = 1;
    all_loaded = false
    function lastAddedLiveFunc()
    {

        if( all_loaded == false ){
          partner_load_count += 1
          $('div#lastPostsLoader').html('<i class="fa fa-spinner fa-pulse fa-5x fa-fw skyblue"></i>');
          $.get("/partners/loadmore?page="+ partner_load_count + '&lat=' + $('#lat').val() + '&lng=' + $('#lng').val(), function(data){
              if (data != "") {
                //console.log('add data..');
                $(".partner-grid").append(data);
                var iso = new Isotope('.partner-grid', {
                  masonry: {
                    columnWidth: 300,
                    isFitWidth: true,
                    "gutter": 50
                  }
                });
                iso.appended( data );
                iso.layout();
              }else{
                all_loaded = true
                $('div#lastPostsLoader').html("No more results");
              }
          });
        }
    };

    $(window).on('scrollstop', function(){});

    // Transform list of partners in partners#index into masonry layout.

    var $grid = $('.partner-grid').isotope({
      // options
      itemSelector: '.partner-grid-item',
      masonry: {
        columnWidth: 300,
        isFitWidth: true,
        "gutter": 50
      }
    });

    // Unloaded images can throw off masonry layout and cause item elements to overlap.
    // imagesLoaded.js resolves this issue.
    // Initialize Isotope, then trigger layout after each image loads:
    $grid.imagesLoaded().progress(function() {
      $grid.isotope('layout');
    });
  }

});
