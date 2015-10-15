// 3.3 Form Submit Event
$(document).ready(function() {
  $('form').on('submit', function(event) {
    event.preventDefault();
  });
});


// 3.4 $.ajax with POST
$(document).ready(function() {
  $('form').on('submit', function(event) {
    event.preventDefault();
    $.ajax('/book', {
      type: 'POST',
      data: $('form').serialize()
    });
  });
});


// 3.5 Success Callback
$(document).ready(function() {
  $('form').on('submit', function(event) {
    event.preventDefault();
    $.ajax('/book', {
      type: 'POST',
      data: $('form').serialize(),
      success: function(res) {
        $('.tour').html(res);
      }
    });
  });
});


// 3.7 The JSON Switch
$(document).ready(function() {
  $('form').on('submit', function(event) {
    event.preventDefault();
    $.ajax('/book', {
      type: 'POST',
      contentType: 'application/json',
      data: $('form').serialize(),
      dataType: 'json',
      success: function(r) {
        var msg = $('<p></p>');
        msg.append(' description: ' + r.description);
        msg.append(' price: ' + r.price);
        msg.append(' nights: ' + r.nights);
        msg.append(' confirmation: ' + r.confirmation);
        $('.tour').html(msg);
      }
    });
  });
});


// 3.8 Don't Repeat Yourself
$(document).ready(function() {
  $('form').on('submit', function(event) {
    event.preventDefault();
    $.ajax($('form').attr('action'), {
      type: $('form').attr('method'),
      data: $('form').serialize(),
      dataType: 'json',
      success: function(response) {
        $('.tour').html('<p></p>')
                  .find('p')
                  .append('Trip to ' + response.description)
                  .append(' at $' + response.price)
                  .append(' for ' + response.nights + ' nights')
                  .append('. Confirmation: ' + response.confirmation);
      }
    });
  });
});
