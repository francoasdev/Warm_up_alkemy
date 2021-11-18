Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :users, except: [:create]
      resources :posts
      post 'auth/login', to: 'auth#create'
      post 'auth/sign_up', to: 'auth#sign_up'
    end
  end
end
