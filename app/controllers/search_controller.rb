require 'csv'

class SearchController < ApplicationController
  def search
    @search_keyword = params[:search_keyword]
    if @search_keyword.present?
      @search_results = search_news(@search_keyword)
    else
      @search_results = []
    end
  end

  private

  def search_news(keyword)
    categories = ['business', 'entertainment', 'health', 'general', 'science', 'sports', 'technology']
    search_results = {}

    categories.each do |category|
      file_path = "public/csv/category/#{category}_news.csv"
      csv_data = CSV.read(file_path, headers: true)

      results = csv_data.select do |row|
        row['Title'].to_s.downcase.include?(keyword.downcase) || row['Description'].to_s.downcase.include?(keyword.downcase)
      end

      search_results[category] = results if results.present?
    end

    search_results
  end
end
