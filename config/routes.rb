# frozen_string_literal: true

Rails.application.routes.draw do
  get 'products/new'
  post 'products/create'
  put 'products/update/:id', to: 'products#update', as: 'products_update'
  get 'products/edit/:id', to: 'products#edit', as: 'products_edit'
  delete 'products/destroy/:id', to: 'products#destroy', as: 'products_destroy'
  get 'products/index'
  get 'reservas/new/:sala/:fecha/:horario', to: 'reservas#new', as: 'new_reserva'
  post 'reservas/new/:sala/:fecha/:horario', to: 'reservas#create'
  get 'movie/new'
  post 'movie/new', to: 'movie#post', as: 'create_movie'
  post 'movie_time/new', to: 'movie#create_movie_time', as: 'new_movie_time'
  get '/', to: 'movie#home', as: 'home'
  get 'movies/list', to: 'movie#list_by_date', as: 'movies_by_date'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
