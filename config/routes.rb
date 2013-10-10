SuiteApi::Application.routes.draw do
  get "idea_threads/index"

  get "logout" => "sessions#destroy", :as => "logout"
  get "me" => 'users#me', :as => 'me'

  get 'user_search' => 'users#index'

  resources :users,      format: :json
  resources :sessions,   format: :json
  resources :ideas,      format: :json do
    resource :votes,     format: :json
    resources :comments, format: :json
  end
  resources :votes,      format: :json
  resources :idea_threads, format: :json
  resources :comments, format: :json

  resources :groups, format: :json
  resources :memberships, format: :json, only: ['destroy']

  get "events" => "events#index", :as => "events"
  resources :voting_rights, format: :json
end
