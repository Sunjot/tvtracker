Rails.application.routes.draw do

  get 'dashboard', to: 'dashboard#display'

  get 'about', to: 'info#about'

  post 'add', to: 'search#add'

  get 'search', to: 'search#query'
  post 'search', to: 'search#query'

  post 'conf', to: 'search#conf'

  # Get and post requests for users
  devise_for :users

  # Get request on the homepage
  get '/', to: 'welcome#index', as: 'home' # equivalent to root

end
