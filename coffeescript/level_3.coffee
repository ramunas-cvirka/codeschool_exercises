// Conditionals
if caffeineLevel > 5
  alert('High Caffeine Level')


// Conditionals - Part II
if caffeineLevel > 5
  alert('Too High')
else
  alert('OK')


// Conditionals - Part III
unless coffeeReady
  alert('Please wait 5 more minutes.')


// Chained Comparisons
if lowLevel < newLevel < highLevel
  alert 'ok'
else
  alert 'abnormal caffeine level'


// Switch / Case
switch newLevel
  when 1 then message = 'Out of bed yet?'
  when 2 then message = 'Good morning!'
  else message = 'You should stop while you can'


// Existential Operator
if newLevel?
  checkLevel(newLevel)
else
  resetLevel()


// Existential Operator - Part II
if level?
  checkLevel?(level)
else
  resetLevel?()
