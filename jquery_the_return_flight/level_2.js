// 2.3 Refactor To Objects
var tour = {
  init: function() {
    $("#tour").on("click", "button", function() {
      $.ajax('/photos.html', {
        data: {location: $("#tour").data('location')},
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
  }
};
$(document).ready(function() {
  tour.init();
});


// 2.4 Event Handler Refactor
var tour = {
  init: function() {
    $("#tour").on("click", "button", this.fetchPhotos);
  },
  fetchPhotos: function() {
    $.ajax('/photos.html', {
      data: {location: $("#tour").data('location')},
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
  }
}
$(document).ready(function() {
  tour.init();
});


// 2.6 Creating a Function
$(document).ready(function() {
   new Tour();
});

var Tour = function() {
  console.log('tour created');
};


// 2.7 Functionality in Functions
function Tour(price) {
  console.log("A new Tour was created");
  this.cost = function(nights) {
    console.log(price * nights);
  };
}
$(document).ready(function() {
  var tour = new Tour(100);
  tour.cost(4);
});


// 2.8 Function Refactor
$(document).ready(function() {
  new Tour($('#paris'));
});

function Tour(obj) {
  console.log(obj);
}


// 2.9 Function Setup
function Tour(el) {
  this.el = el;
  this.fetchPhotos = function() {};
  el.on("click", "button", this.fetchPhotos);
}
$(document).ready(function() {
  var paris = new Tour($('#paris'));
});


// 2.10 fetchPhotos Refactor
function Tour(el) {
  var tour = this;
  this.el = el;
  this.fetchPhotos = function() {
    $.ajax('/photos.html', {
      context: tour,
      data: {location: tour.el.data('location')},
      success: function(response) {
        this.el.find('.photos').html(response).fadeIn();
      },
      error: function() {
        this.el.find('.photos').html('<li>There was a problem fetching the latest photos. Please try again.</li>');
      },
      timeout: 3000,
      beforeSend: function() {
        this.el.addClass('is-fetching');
      },
      complete: function() {
        this.el.removeClass('is-fetching');
      }
    });
  };
  this.el.on('click', 'button', this.fetchPhotos);
}
$(document).ready(function() {
  var paris = new Tour($('#paris'));
});


// 2.11 Instances of a Function
function Tour(el) {
  var tour = this;
  this.el = el;
  this.fetchPhotos = function() {
    $.ajax('/photos.html', {
      data: {location: tour.el.data('location')},
      context: tour,
      success: function(response) {
        this.el.find('.photos').html(response).fadeIn();
      },
      error: function() {
        this.el.find('.photos').html('<li>There was a problem fetching the latest photos. Please try again.</li>');
      },
      timeout: 3000,
      beforeSend: function() {
        this.el.addClass('is-fetching');
      },
      complete: function() {
        this.el.removeClass('is-fetching');
      }
    });
  }
  this.el.on('click', 'button', this.fetchPhotos);
}
$(document).ready(function() {
  var paris = new Tour($('#paris'));
  var london = new Tour($('#london'));
});
