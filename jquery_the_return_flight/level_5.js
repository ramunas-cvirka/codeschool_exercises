// 5.3 Removing Event Handlers
$(document).ready(function(){
  // Get Weather
  $('button').on('click', function() {
    var results = $(this).closest('li').find('.results');
    results.append('<p>Weather: 74&deg;</p>');
    $(this).off('click');
  });
});


// 5.4 Namespacing Event Handlers
$(document).ready(function(){
  // Get Weather
  $('button').on('click.weather', function() {
    var results = $(this).closest('li').find('.results');
    results.append('<p>Weather: 74&deg;</p>');
    $(this).off('click.weather');
  });

   // Show Photos
  $('button').on('click.photos', function() {
    var tour = $(this).closest('li');
    var results = tour.find('.results');
    results.append('<p><img src="/assets/photos/'+tour.data('loc')+'.jpg" /></p>');
    $(this).off('click.photos');
  });
});


// 5.5 Trigger
$(document).ready(function(){
  // Get Weather
  $('button').on('click.weather', function() {
    var results = $(this).closest('li').find('.results');
    results.append('<p>Weather: 74&deg;</p>');
    $(this).off('click.weather');
  });

   // Show Photos
  $('button').on('click.photos', function() {
    var tour = $(this).closest('li');
    var results = tour.find('.results');
    results.append('<p><img src="/assets/photos/'+tour.data('loc')+'.jpg" /></p>');
    $(this).off('click.photos');
  });

  $('button').trigger('click');
});


// 5.6 Custom Events
$(document).ready(function(){
  // Get Weather
  $('button').on('boom.weather', function() {
    var results = $(this).closest('li').find('.results');
    results.append('<p>Weather: 74&deg;</p>');
    $(this).off('boom.weather');
  });

  // Show Photos
  $('button').on('click.photos', function() {
    var tour = $(this).closest('li');
    var results = tour.find('.results');
    results.append('<p><img src="/assets/photos/'+tour.data('loc')+'.jpg" /></p>');
    $(this).off('click.photos');
    $('button').trigger('boom.weather');
  });
});


// 5.8 Declaring a jQuery plugin
$.fn.photofy = function() {
  console.log(this);
};
$(document).ready(function() {
  $('.tour').photofy();
});


// 5.9 Iteration with each
$.fn.photofy = function() {
  this.each(function() {
    console.log(this);
  });
}
$(document).ready(function() {
  $('.tour').photofy();
});


// 5.10 Plugin Event
$.fn.photofy = function() {
  this.each(function() {
    var tour = $(this);
    tour.on('click.photofy', '.see-photos', function(e) {
      e.preventDefault();
      tour.addClass('is-showing-photofy');
    })
    console.log(this);
  });
}
$(document).ready(function() {
  $('.tour').photofy();
});


// 5.11 Using $.extend()
$.fn.photofy = function(options) {
  this.each(function() {
    var settings = $.extend({ count: 3, tour: $(this)}, options);
    var show = function(e) {
       e.preventDefault();
       settings.tour
               .addClass('is-showing-photofy')
               .find('.photos')
               .find('li:gt('+(settings.count-1)+')').hide();
     }

     settings.tour.on('click.photofy', '.see-photos', show);
  });
}
$(document).ready(function() {
  $('.tour').photofy({ count: 1});
});


// 5.12 External Triggers
$.fn.photofy = function(options) {
  this.each(function() {

    var show = function(e) {
      e.preventDefault();
      settings.tour
              .addClass('is-showing-photofy')
              .find('.photos')
              .find('li:gt('+(settings.count-1)+')')
              .hide();
    }
    var settings = $.extend({
      count: 3,
      tour: $(this)
    }, options);
    settings.tour.on('click.photofy', '.see-photos', show);
    settings.tour.on('show.photofy', show);
  });
}
$(document).ready(function() {
  $('.tour').photofy({ count: 1});

  $('.show-photos').on('click', function(e) {
    e.preventDefault();
    // Trigger
    $('.tour').trigger('show.photofy');
  });
});


// 5.13 Internal Triggers
$.fn.photofy = function(options) {
  this.each(function() {
    var show = function(e) {
      e.preventDefault();
      settings.tour
              .addClass('is-showing-photofy')
              .find('.photos')
              .find('li:gt('+(settings.count-1)+')')
              .hide();
    }
    var settings = $.extend({
      count: 3,
      tour: $(this)
    }, options);
    settings.tour.on('click.photofy', '.see-photos', show);
    settings.tour.on('click.photofy', '.hide-tour', function(e) {
      e.preventDefault();
      settings.tour.fadeOut().off('.photofy');
    });
    settings.tour.on('show.photofy', show);
  });
}

$(document).ready(function() {
  $('.tour').photofy({ count: 1});

  $('.show-photos').on('click', function(e) {
    e.preventDefault();
    $('.tour').trigger('show.photofy');
  });
});
