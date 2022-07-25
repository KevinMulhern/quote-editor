Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users
  resources :quotes do
    resources :line_item_dates, except: [:index, :show]
  end
end
