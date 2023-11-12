# app/controllers/main2_controller.rb
require 'csv'

class Main2Controller < ApplicationController
  def main2
    @good_news = load_news_with_keyword('public/csv/fill/good_news_with_keyword.csv')
    @bad_news = load_news_with_keyword('public/csv/fill/bad_news_with_keyword.csv')
    shuffled_good_news = @good_news.values.flatten.shuffle
    shuffled_bad_news = @bad_news.values.flatten.shuffle
  
    @combined_news = []
    shuffled_good_news.each_with_index do |good, index|
      @combined_news << good
      @combined_news << shuffled_bad_news[index] if shuffled_bad_news[index]
    end
  end

  private

  def load_news_with_keyword(csv_file_path)
    news = Hash.new { |hash, key| hash[key] = [] }
    
    if File.exist?(csv_file_path)
      data = CSV.read(csv_file_path, headers: true)

      data.each do |row|
        category = row['Category']
        news[category] << row.to_h
      end
    end

    news
  end
end