Rails.application.routes.draw do

  get 'studios', to: 'studios#index'

  get 'actors/:id', to: 'actors#show'

  get 'movies/:id', to: 'movie_actors#show'
  post 'movies/:id', to: 'movie_actors#create'
end
