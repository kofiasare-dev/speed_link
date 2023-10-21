# frozen_string_literal: true

require 'karafka/web'

Rails.application.routes.draw do
  mount Karafka::Web::App, at: '/kf'

  namespace :api, default: { format: 'json' } do
    namespace :v1 do
      post '/locations', to: 'locations#create'
      post '/graph', to: 'graph#execute'
    end
  end
end
