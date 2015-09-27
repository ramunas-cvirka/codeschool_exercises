# RESOURCE ROUTE
TwitterForZombies::Application.routes.draw do
  resources :zombies
end

# ROUTE MATCHING
TwitterForZombies::Application.routes.draw do
  get '/undead' => 'zombies#undead'
end

# ROUTE REDIRECTING
TwitterForZombies::Application.routes.draw do
  get '/undead' => redirect('/zombies')
end

# ROOT ROUTE
TwitterForZombies::Application.routes.draw do
  root 'zombies#index'
end

# NAMED ROUTE
TwitterForZombies::Application.routes.draw do
  get '/zombies/:name', to: 'zombies#index', as: 'graveyard'
end
