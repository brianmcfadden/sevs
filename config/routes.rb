Rails.application.routes.draw do
  get 'sevs', to: 'sevs#main'
  get 'sevs/main', to: 'sevs#main'
  root 'sevs#main'
  resources :side_effects
  resources :symptoms
  resources :drugs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
