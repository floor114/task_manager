Rails.application.routes.draw do
  devise_for :users
  root 'tasks#index'
  resources :tasks do
    member do
      post :share
    end
    collection do
      get :render_modal
    end
  end

  mount ActionCable.server => '/cable'
end
