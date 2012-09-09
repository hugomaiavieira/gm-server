Gm::Application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      post 'users' => 'users#create'
      post 'users/sign_in' => 'users#sign_in'
    end
  end

  root to: 'site#index'
end
