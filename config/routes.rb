Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :projects, except: :show do
        resources :tasks, except: :show do
          resources :comments, except: [:show, :update]
        end
      end

      post 'users/sign_in'
      post 'users/sign_up'
    end
  end
end
