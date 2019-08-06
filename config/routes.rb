# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  if Rails.env.production? 
  then
    root 'sevs#index'
    resources :sevs, only: [:index]
    resources :side_effects, only: [:index, :show]
    resources :symptoms, only: [:index, :show]
    resources :drugs, only: [:index, :show]
  else
    resources :manufacturers
    resources :classifications
    root 'sevs#index'
    resources :sevs, only: [:index]
    resources :side_effects
    resources :symptoms
    resources :drugs
  end
end
