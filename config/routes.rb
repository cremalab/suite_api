SuiteApi::Application.routes.draw do
  resources :comments, format: :json,       except: [:new, :edit]

  resources :groups, format: :json,         except: [:new, :edit]

  resources :ideas,      format: :json,     except: [:new, :edit] do
    resource :votes,     format: :json,     only:   [:show, :create, :destroy]
    resources :comments, format: :json

  end

  resources :idea_threads, format: :json,   except: [:new, :edit]

  resources :memberships, format: :json,    only:   [:destroy]

  resources :notification_settings, format: :json,    only:   [:update]


  resources :sessions,   format: :json,     only:   [:create, :destroy]
  get "logout" => "sessions#destroy", :as => "logout"

  resources :users,      format: :json,     except: [:new, :edit, :destroy]
  get 'user_search' => 'users#index'
  get "me" => 'users#me', :as => 'me'

  resources :votes,      format: :json,     only:   [:show, :create, :destroy]


  resources :voting_rights, format: :json,  only:  [:show, :create, :destroy]
end
