Rails.application.routes.draw do
  resources :side_effects
  resources :symptoms
  resources :drugs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
