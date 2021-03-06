# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  if Rails.env.production? 
  then
    root 'sevs#index'
    resources :sevs, only: [:index, :create]
    resources :side_effects, only: [:index, :show]
    resources :symptoms, only: [:index, :show]
    resources :drugs, only: [:index, :show]
    get 'check/:type/:text', to: 'check#check'
    get 'check/:type', to: 'check#check'
  else
    resources :manufacturers
    resources :classifications
    root 'sevs#index'
    resources :sevs, only: [:index, :create]
    resources :side_effects, only: [:index, :show, :new, :edit, :create, :destroy]
    resources :symptoms, only: [:index, :show, :new, :edit, :create, :destroy]
    resources :drugs, only: [:index, :show, :new, :edit, :create, :destroy]
    get 'check/:type/:text', to: 'check#check'
    get 'check/:type', to: 'check#check'
  end
end
