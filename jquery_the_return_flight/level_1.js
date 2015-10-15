//1.3 Ajax
$(document).ready(function() {
  $('#tour').on('click', 'button', function() {
    $.ajax('/photos.html')
  });
});


//1.4 Ajax with Response
$(document).ready(function() {
  $('#tour').on('click', 'button', function() {
    $.ajax('/photos.html', {
      success: function(response) {
        $('.photos').html(response).fadeIn();
      }
    });
  });
});


//1.5 $.get Shorthand
$(document).ready(function() {
  $('#tour').on('click', 'button', function() {
    $.get('/photos.html', function(response) {
        $('.photos').html(response).fadeIn();
    });
  });
});


//1.6 Ajax Data
$(document).ready(function() {
  $("#tour").on("click", "button", function() {
    $.ajax('/photos.html', {
      success: function(response) {
        $('.photos').html(response).fadeIn();
      },
      data: { 'location': $('#tour').data('location')
      }
    });
  });
});


//1.8 Ajax with Errors
$(document).ready(function() {
  var el = $("#tour");
  el.on("click", "button", function() {
    $.ajax('/photos.html', {
      data: {location: el.data('location')},
      success: function(response) {
        $('.photos').html(response).fadeIn();
      },
      error: function(req, eT, eM) {
        $('.photos').html('<li>Something went wrong</li>');
      }
    });
  });
});


//1.9 Setting a Timeout
$(document).ready(function() {
  var el = $("#tour");
  el.on("click", "button", function() {
    $.ajax('/photos.html', {
      data: {location: el.data('location')},
      success: function(response) {
        $('.photos').html(response).fadeIn();
      },
      error: function() {
        $('.photos').html('<li>There was a problem fetching the latest photos. Please try again.</li>');
      },
      timeout: 3000
    });
  });
});


//1.10 More Ajax Callbacks
$(document).ready(function() {
  $("#tour").on("click", "button", function() {
    $.ajax('/photos.html', {
      success: function(response) {
        $('.photos').html(response).fadeIn();
      },
      error: function() {
        $('.photos').html('<li>There was a problem fetching the latest photos. Please try again.</li>');
      },
      timeout: 3000,
      beforeSend: function() { $('#tour').addClass('is-fetching'); },
      complete: function() { $('#tour').removeClass('is-fetching'); }
    });
  });
});


//1.11 Event Delegation
$(document).ready(function() {
  function showPhotos() {
    $(this).find('span').slideToggle();
  }
  $('.photos').on('mouseenter', 'li', showPhotos)
              .on('mouseleave', 'li', showPhotos);


  var el = $("#tour");
  el.on("click", "button", function() {
    $.ajax('/photos.html', {
      data: {location: el.data('location')},
      success: function(response) {
        $('.photos').html(response).fadeIn();
      },
      error: function() {
        $('.photos').html('<li>There was a problem fetching the latest photos. Please try again.</li>');
      },
      timeout: 3000,
      beforeSend: function() {
        $('#tour').addClass('is-fetching');
      },
      complete: function() {
        $('#tour').removeClass('is-fetching');
      }
    });
  });
});
