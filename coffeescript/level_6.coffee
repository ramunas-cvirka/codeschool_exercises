# Classes - Part I
class Coffee
  constructor: (@name, @level) ->
  isRussian: -> @name is 'Russian'


# Classes - Part II
coffee = new Coffee('ramunas', 31)


# Property Arguments
class Coffee
  constructor: (@name, @level = 0) ->
  isRussian: -> @name is 'Russian'


# Class Inheritance
class Coffee extends Drink
  constructor: (@name, @level=0) ->
  serve: ->
    if @sleeve == false
       false
    else
      super()


# Classes with jQuery
class DrinkLink
  watchClick: ->
    $('a').click -> $('a').css(color: '#F00')


# Watch those @'s
class DrinkLink
  constructor: (@linkClicked=false) ->
  watchClick: ->
    $('.drink a').click (event) =>
      $(event.target).css('color', '#F00')
      @linkClicked = true
