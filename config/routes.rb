Gm::Application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      #= Users
      post 'users' => 'users#create'
      post 'users/sign_in' => 'users#sign_in'

      #= Categories
      post 'categories/sync' => 'categories#sync'
    end
  end

  root to: 'site#index'
end
