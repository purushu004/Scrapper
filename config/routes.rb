Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'links/new'
  root 'links#new'
  get '/scraper' => 'scraper#scraper'
  get '/get_7days_data' => 'scraper#get_7days_data'
  get '/get_30days_data' => 'scraper#get_30days_data'
  resources :scrapers
  resources :links
end

