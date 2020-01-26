# frozen_string_literal: true

Rails.application.routes.draw do
  scope(path_names: { new: "join" }) do
    resources :clients, only: %i(new create show edit update)
  end

  scope(path_names: { new: "join" }) do
    resources :planners, only: %i(new create show edit update)
  end

  resources :planners, only: [] do
    resources :available_frames, only: %i(index create destroy)
  end

  resources :clients, only: [] do
    resources :available_frames, only: %i(index)
    resources :reservations, only: %i(new create destroy)
  end

  scope :user do
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
