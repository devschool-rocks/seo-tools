Rails.application.routes.draw do

  resources :domains
  resources :keywords
  resources :serps
  resources :seo_grades

  match '/update' => "serps#update", via: :get

  root to: "serps#index"

end
