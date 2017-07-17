Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }
  devise_scope :user do
    authenticated :user do
      root :to => 'topics#index'
    end

    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :topics do
    resources :questions do
      get 'statistics'
      get 'data'
      resources :answers
    end
  end

  get 'questions/:question_id/data' => 'answers#data'
  post 'question/:question_id/create' => 'answers#create'

end
