# app/controllers/main2_controller.rb
require 'csv'

class Main2Controller < ApplicationController
  def main2
    @good_news = load_news_with_keyword('public/csv/fill/good_news_with_keyword.csv')
    @bad_news = load_news_with_keyword('public/csv/fill/bad_news_with_keyword.csv')
  end

  private

  def load_news_with_keyword(csv_file_path)
    news = []
    
    if File.exist?(csv_file_path)
      data = CSV.read(csv_file_path, headers: true)

      data.each do |row|
        news << row.to_h
      end
    end

    news
  end
end
