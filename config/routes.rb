Rails.application.routes.draw do
  get 'main' => 'main#main'
  get 'keyword' => "keyword#keyword"
  get 'survey' => "survey#survey"
  root "top#top"
  get 'search' => "search#search"
  get 'allnews' => "allnews#index"
  post 'submit_survey', to: 'survey#submit_survey'
  post 'survey/submit_feedback', to: 'survey#submit_feedback'
  post 'survey/feedback'
  post 'keyword/save_survey', to: 'keyword#save_survey'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
