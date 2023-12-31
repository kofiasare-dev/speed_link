# frozen_string_literal: true

require 'sidekiq/web'

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: '_interslice_session'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sk'

  namespace :api, default: { format: 'json' } do
    namespace :v1 do
      post '/graph', to: 'graph#execute'
    end
  end
end
