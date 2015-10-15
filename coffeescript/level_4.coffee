// Coffee on the Range
[1..10]


// Coffee on the Range II
[1...11]


// Object Literals
coffee = name: 'Russian', level: 2, isRussian: -> true


// For In Loop
for el in people
  console.log(el.name) if el.age > 18


// List Comprehension
console.log(person.name) for person in people when person.age > 18


// List Comprehension II
addCoffee(coffee) for coffee in coffeeList when not coffee.isRussian?()


// Splat Arguments
displayTopPicks = (bestCoffee, suggested...) ->
  alert('Top #1 ' + bestCoffee)
  alert('Suggested: ' + suggested.join(", "))
