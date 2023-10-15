Rails.application.routes.draw do
  root "top#top"
  get 'search' => "search#index"
  get 'allnews' => "allnews#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
