Baseball::Application.routes.draw do
  resources :statistics


  resources :players do
    collection do
      get 'details'
    end
  end


  root :to => "home#index"
end
