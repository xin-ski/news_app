class AllnewsController < ApplicationController
  def index
    @news = []
    categories = ['business', 'entertainment', 'health', 'general', 'science', 'sports', 'technology']
    categories.each do |category|
      file_path = "public/csv/category/#{category}_news.csv"
      CSV.foreach(file_path, headers: true) do |row|
        @news << {
          title: row['Title'],
          description: row['Description'],
          category: category,
          url: row['URL']
        }
      end
    end
  end
end