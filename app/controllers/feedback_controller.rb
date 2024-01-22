#app/controllers/feedback_controller.rb
#goodカテゴリとbadカテゴリ分けcsvへ保存
class FeedbackController < ApplicationController
  def categorize_news
    feedback_data = CSV.read('public/csv/feedback/feedback.csv', headers: true)

    good_news = {}
    bad_news = {}

    feedback_data.each do |row|
      category = row['category']
      survey = row['survey'].to_i

      if survey == 1
        add_news_to_category(good_news, category)
      else
        add_news_to_category(bad_news, category)
      end
    end

    save_news_to_csv(good_news, 'public/csv/good_news.csv')
    save_news_to_csv(bad_news, 'public/csv/bad_news.csv')
    redirect_to root_path
  end

  private

  def add_news_to_category(news_data, category)
    news_file = "public/csv/category/#{category}_news.csv"

    if File.exist?(news_file)
      news_data[category] = CSV.read(news_file, headers: true)
    end
  end

  def save_news_to_csv(news_data, file_path)
    CSV.open(file_path, 'w') do |csv|
      csv << %w[Category Title Description URL]
      
      news_data.each do |category, news|
        news.each do |row|
          csv << [category, row['Title'], row['Description'], row['URL']]
        end
      end
    end
  end
end
