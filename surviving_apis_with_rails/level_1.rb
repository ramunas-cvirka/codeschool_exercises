# 1.2 Limiting Resources
SurvivingRails::Application.routes.draw do
  resources :humans, except: :destroy
  resources :weapons, only: [:index, :show]
end

# 1.3 Restricting Multiple Actions
SurvivingRails::Application.routes.draw do
  with_options only: :index do |l|
    l.resources :zombies
    l.resources :humans
    l.resources :medical_kits
    l.resources :broadcasts
  end
  resources :messages, except: :destroy
end

# 1.4 Constraints and Namespaces
SurvivingRails::Application.routes.draw do
  resources :announcements
  namespace :api, path: '/', constraints: { subdomain: 'api' } do
    resources :zombies
    resources :humans
  end
end