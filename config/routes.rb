# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :hotline do
    resources :services
  end
  namespace :hotline do
    resources :categories
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
