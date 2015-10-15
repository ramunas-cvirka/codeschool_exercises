// JS to Coffee
$ ->
  $('#newCoffee a').click ->
     alert('New coffee added')


// JS to CS - Part II
$('#newCoffee a').click ->
  name = prompt('Name of coffee:')
  alert("New coffee added: #{name}")


// JS to CS - Part III
$('#newCoffee a').click ->
  name = prompt('Name of coffee:')
  coffee = $("<li>#{name}</li>")
  $('ul.drink').append(coffee)


// JS to CS - Part IV
$('.drink li a').click (e) ->
   e.preventDefault()
   alert($(@).text())


// JS to CS - Part V
$('.drink li').mouseenter ->
   $(@).find('span').show()
$('.drink li').mouseleave ->
   $(@).find('span').hide()


// JS to CS - Part VI
$('.drink li').hover ->
   $(@).find('span').show()
,->
   $(@).find('span').hide()
