$(document).ready(function() {

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

});
