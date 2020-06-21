Rails.application.routes.draw do
  resources :games do
    get '/board', to: 'board#show'
    get '/board/:row/:col', to: 'cell#show'
    match '/board/:row/:col', to: 'cell#update', via: [:put, :patch]
  end
end
