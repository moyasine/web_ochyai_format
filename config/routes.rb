Rails.application.routes.draw do
  get 'templetes/index'

  get 'templetes/new'

  get 'templetes/create'

  get 'generate_format/index'
  resources :templetes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
