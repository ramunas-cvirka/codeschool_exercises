# MATCH I
ZombieOutlaws::Application.routes.draw do
  match '/outlaws', to: 'zombies#outlaws', via: :post
end

# MATCH II
ZombieOutlaws::Application.routes.draw do
  match '/outlaws', to: 'zombies#outlaws', via: :get
end

# MATCH III
ZombieOutlaws::Application.routes.draw do
  match '/undeads', to: 'undeads#index', via: :all
end

# HTTP PATCH
class WeaponsControllerTest < ActionController::TestCase
  test "updates weapon" do
    patch :update, zombie_id: @zombie, weapons: { name: 'Scythe' }
    assert_redirected_to zombie_url(@zombie)
  end
end

# ROUTING CONCERNS I
ZombieOutlaws::Application.routes.draw do
  
  concern :defensible do
    resources :shotguns
    resources :rifles
    resources :knives
  end
  
  resources :sheriffs, concerns: :defensible
  resources :gunslingers, concerns: :defensible
  resources :preachers, concerns: :defensible
end

# ROUTING CONCERNS - PART II
ZombieOutlaws::Application.routes.draw do
  concern :defensible do |options|
    resources :shotguns, options
    resources :rifles, options
    resources :knives, options
  end

  resources :sheriffs, concerns: :defensible
  resources :gunslingers, concerns: :defensible
  resources :preachers do
    concerns :defensible, except: :destroy
  end
end

# THREAD SAFETY
ZombieOutlaws::Application.configure do
  # config.threadsafe!
  config.cache_classes = true
  config.eager_load = true
end
