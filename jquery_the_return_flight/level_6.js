// 6.3 Reusable AJAX
var Vacation = {
  getPrice: function(location) {
    var pr = $.ajax('/vacation/prices', {
      data: {q: location},
      success: function(result){
        $('.price').text(result.price);
      }
    });
    return pr;
  }
};


// 6.4 Using the Vacation
$(document).ready(function() {
  $('button').on('click', function(){
    var location = $('.location').text();
    var vac = Vacation.getPrice(location);
    vac.done(function(result) {
      $('.price').text(result.price);
    });
  });
});


// 6.5 Simplifying the result
var Vacation = {
  getPrice: function(location) {
    var promise = $.Deferred();
    $.ajax('/vacation/prices', {
      data: {q: location},
      success: function(res) {
        promise.resolve(res.price);
      }
    });
   return promise;
  }
}


// 6.6 The Simple Result
$(document).ready(function() {
  $('button').on('click', function(){
    var location = $('.location').text();
    Vacation.getPrice(location).done(function(result){
      $('.price').text(result);
    });
  });
});


// 6.7 Promising Errors
var Vacation = {
  getPrice: function(location){
    var promise = $.Deferred();
    $.ajax({
      url: '/vacation/prices',
      data: {q: location},
      success: function(result){
        promise.resolve(result.price);
      },
      error: function() {
        promise.reject('there was an error');
      }
    });
    return promise;
  }
}


// 6.8 Fail()
$(document).ready(function() {
  $('button').on('click', function(){
    var location = $('.location').text();
    Vacation.getPrice(location).done(function(result){
      $('.price').text(result);
    }).fail(function(result) {
      console.log(result);
    });
  });
});


// 6.9 When() and Then()
$(document).ready(function() {
  $('button').on('click', function(){
    var tour = $(this).parent();
    var location = tour.data('location');
    var resultDiv = tour.find('.results').empty();

    $.when(Vacation.getPrice(location), Photo.getPhoto(location))
    .then(function(priceResult, photoResult) {
      $('<p>$'+priceResult+'</p>').appendTo(resultDiv);
      $('<img />').attr('src', photoResult).appendTo(resultDiv);
    });
  });
});
