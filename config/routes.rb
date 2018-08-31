Rails.application.routes.draw do
 root 'users#new'
 root to: "blogs#index"
 get 'users/favorite', to: 'users#favorite'
 resources :favorites, only: [:create, :destroy]
 resources :blogs do
    collection do
      post :confirm
    end
  end
 resources :sessions, only: [:new, :create, :destroy]
 resources :users, only: [:new, :create, :show]
 mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
