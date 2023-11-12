Rails.application.routes.draw do
  get '/manual_update', to: 'top#manual_update', as: 'manual_update'
  get 'main' => 'main#main'
  get 'main2' => 'main2#main2'
  get 'keyword' => "keyword#keyword"
  get 'survey' => "survey#survey"
  root "top#top"
  get 'search' => "search#search"
  get 'allnews' => "allnews#index"
  post 'submit_survey', to: 'survey#submit_survey'
  post 'survey/submit_feedback', to: 'survey#submit_feedback'
  post 'survey/feedback'
  post 'keyword/save_survey', to: 'keyword#save_survey'
  post 'write_csv', to: 'main#write_csv'
  post 'process_feedback', to: 'feedback#process_feedback'
  get 'feedback/categorize_news', to: 'feedback#categorize_news', as: 'categorize_news_feedback'
  get '/test/show_interesting_news', to: 'test#show_interesting_news'
  get 'test/index' # 例：test/indexへのGETリクエストに対するルーティング
  post 'test/categorize_and_save_news' # 例：test/categorize_and_save_newsへのPOSTリクエストに対するルーティング
  # config/routes.rb
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end