Rails.application.routes.draw do
  get '/auth/facebook/callback', to: 'sessions#create_from_facebook'
  get '/auth/google_oauth2/callback', to: 'sessions#create_from_google_oauth2'
  get '/auth/microsoft_v2_auth/callback', to: 'sessions#create_from_microsoft_v2_auth'
  get '/sign_in' => 'sessions#new', :as => 'sign_in'
  delete '/sign_out' => 'sessions#destroy', :as => 'sign_out'
  get '/sign_up' => 'users#sign_up'

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
  end

  post '/graphql', to: 'graphql#execute'

  root to: 'web#index'
  get '*path', to: 'web#index'
end
