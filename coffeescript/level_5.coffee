// jQuery & Object Notation
$ ->
   $('.drink a').click ->
     newStyle =
       'color': '#F00'
       'font-weight': 'bold'
     $(@).css(newStyle)


// jQuery & Object Notation - Part II
coffeeList = ->
  init ->
    $('.drink a').click (e) ->
      e.preventDefault()
      alert $(@).text()
coffeeList.init()


// jQuery & Object Notation - Part III
 $.ajax
   url: '/coffeeList'
   method: 'GET'
   success: (results) ->
     $('ul.drink').append("<li>#{coffee.name}</li>") for coffee in results when coffee.level > 3
   error: (results) ->
     alert("failure " + results)
