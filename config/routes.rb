Rails.application.routes.draw do

  get 'about', to: 'info#about'

  get 'search', to: 'search#query'
  post 'search', to: 'search#query'

  # Get and post requests for users
  devise_for :users

  # Get request on the homepage
  get '/', to: 'welcome#index', as: 'home' # equivalent to root

end
