// 4.3 Using $.each() I
$('button').on('click', function() {
  $.ajax('/cities/deals', {
    success: function(result) {
      $.each(result, function(ind, el) {
        console.log(el);
      });
    }
  });
});


// 4.4 Using $.each() II
$('button').on('click', function() {
  $.ajax('/cities/deals', {
    success: function(result) {
      $.each(result, function(index, dealItem) {
        $('.deal-'+index+' h3').html(dealItem.name);
        $('.deal-'+index+' p').html(dealItem.price);
      });
    }
  });
});


// 4.5 Using $.each() II
$('button').on('click', function() {
  $.getJSON('/cities/deals',  function(result) {
    $.each(result, function(index, dealItem) {
      var dealElement = $('.deal-' + index);
      dealElement.find('.name').html(dealItem.name);
      dealElement.find('.price').html(dealItem.price);
    });
  });
});


// 4.6 Using $.map() I
$('.update-available-flights').on('click', function() {
  $.getJSON('/flights/late', function(result) {
    $.map(result, function(i) {
      console.log(i);
    });
  });
});


// 4.7 Using $.map() II
$('.update-available-flights').on('click', function() {
  $.getJSON('/flights/late', function(result) {
    var flightElements = $.map(result, function(flightItem, index){
      var list = $('<li></li>');
      return list.append('flightNumber: ' + flightItem.flightNumber + ' time: ' + flightItem.time );
    });
    $('.flight-times').html('<ul></ul>').append(flightElements);
  });
});


// 4.8 detach()
$('.update-available-flights').on('click', function() {
  $.getJSON('/flights/late', function(result) {
    var flightElements = $.map(result, function(flightItem, index){
      var flightEl = $('<li>'+flightItem.flightNumber+'-'+flightItem.time+'</li>');
      return flightEl;
    });
    $('.flight-times').detach().html(flightElements).appendTo('.flights');
  });
});
