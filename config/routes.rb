# frozen_string_literal: true

Rails.application.routes.draw do
  scope(path_names: { new: "join" }) do
    resources :clients, only: %i(new create show edit update)
  end

  # もっと良い書き方がありそう
  resource :user do
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
