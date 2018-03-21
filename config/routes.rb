Rails.application.routes.draw do

  
  resources :foos, except: [:new, :edit]
  scope :api, defaults: {format: :json} do
    resources :cities, except: [:new, :edit]
    resources :states, except: [:new, :edit]
    resources :foos, except: [:new, :edit]
  end
  
  get '/ui' => 'ui#index'
  get '/ui#' => 'ui#index'
  root "ui#index"
end
