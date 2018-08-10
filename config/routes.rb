Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :projects do
        resources :todos do
          resources :comments
        end
      end

      post 'users/sign_in'
      post 'users/sign_up'
    end
  end
end
