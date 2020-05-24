Rails.application.routes.draw do
  resources :people
  get "/welcome/hello" => 'welcome#say'
  get "/welcome" => 'welcome#index'
  root "welcome#index"
  resources :events
end
