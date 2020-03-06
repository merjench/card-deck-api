Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
       resources :cards
       resources :decks
       get "/sort", to: "cards#sort"
    end 
  end 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
