Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'

  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },

    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }

  resources :brands do
    member do
      post :change_status
    end

    resources :products do
      member do
        post :change_status
      end
    end
  end
end
