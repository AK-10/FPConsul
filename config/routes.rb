# frozen_string_literal: true

Rails.application.routes.draw do
  scope(path_names: { new: "join" }) do
    resources :users, only: %i(new show create edit update)
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
