Rails.application.routes.draw do
  devise_for :users
  resources :people
  get "/welcome/hello" => 'welcome#say'
  get "/welcome" => 'welcome#index'
  root "welcome#index"
  resources :events do
    resources :attendees, :controller => 'event_attendees'

    collection  do 
      get :latest
      post :bulk_update
    end

    member do
      get :dashboard
    end
  end
  namespace :admin do
    resource :events # 加入后台管理的 events 和 上面的不一样
  end
end
