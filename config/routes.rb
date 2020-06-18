Rails.application.routes.draw do
  resources :games do
    resources :board
  end
end
