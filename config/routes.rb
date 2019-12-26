# frozen_string_literal: true

Rails.application.routes.draw do
  scope(path_names: { new: "join", show: 'home' }) do
    resource :user, only: %i(new show create edit update)
  end

  # もっと良い書き方がありそう
  resource :user do
    get "/login", to: "user/sessions#new"
    post "/login", to: "user/sessions#create"
    delete "/logout", to: "user/sessions#destroy"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
