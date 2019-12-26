# frozen_string_literal: true

Rails.application.routes.draw do
  scope(path_names: { new: "join" }) do
    resource :user, only: %i(new show create edit update)
    # もっと上手い書き方がありそう
    resource :users do
      get "/login", to: "users/session#new"
      post "/login", to: "users/session#create"
      delete "/logout", to: "users/session#destroy"
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
