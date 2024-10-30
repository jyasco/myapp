Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  root 'static_pages#top'
  get 'contact', to: 'static_pages#contact', as: :contact
  get 'terms', to: 'static_pages#terms', as: :terms_of_service
  get 'privacy', to: 'static_pages#privacy', as: :privacy_policy

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'sign_up'
  }

  resources :posts

  namespace :mypage do
    get '/', to: 'posts#index', as: :mypage
    resources :posts, only: [:index]
    resources :bookmark_posts, only: [:index]
  end

  resources :bookmarks, only: %i[create destroy]
end
