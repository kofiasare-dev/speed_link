# frozen_string_literal: true

require 'karafka/web'

Rails.application.routes.draw do
  mount Karafka::Web::App, at: '/kf'

  get 'up' => 'rails/health#show', as: :rails_health_check
end
