require 'net/http'
require 'json'
require 'csv'

class TopController < ApplicationController
  before_action :save_news_to_csv, only: [:index]

  def top
    categories = ['business', 'entertainment', 'health', 'general', 'science', 'sports', 'technology']
    
    # ニュースAPIのエンドポイント
    api_key = 'aafeb0839125431688440b7346e9d2dc' # ご自身のAPIキーに置き換えてください
    base_endpoint = "https://newsapi.org/v2/top-headlines?country=jp&apiKey=#{api_key}"
    
    categories.each do |category|
      endpoint = "#{base_endpoint}&category=#{category}"
      uri = URI(endpoint)
      response = Net::HTTP.get(uri)
      data = JSON.parse(response)
    
      articles = data['articles']
    
      if articles
        CSV.open("public/csv/category/#{category}_news.csv", 'w') do |csv|
          # CSVヘッダーを書き込み
          csv << ['Title', 'Description', 'URL']
    
          articles.each do |article|
            title = article['title']
            description = article['description']
            url = article['url']
    
            # CSVファイルにデータを書き込み
            csv << [title, description, url]
          end
        end
    
        puts "Saved #{category} news to #{category}_news.csv"
      else
        puts "No articles found for #{category} category."
      end
    end
  end
end