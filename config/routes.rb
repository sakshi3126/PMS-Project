Rails.application.routes.draw do
  resources :tasks
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end
  devise_for :users, :controllers => {:registrations => "registrations"}
  # # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    authenticated  do
      root to: 'projects#index'
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: 'unauthenticated_path'
    end
  end

  resources :projects do
    member do
      patch  'update_task'
    end
    resources :tasks
  end
  resources :tasks
end