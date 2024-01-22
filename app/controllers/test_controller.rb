#興味のあるカテゴリ and 興味のあるキーワード（good）
#興味のないカテゴリ and 興味のあるキーワード(bad)でニュースの分類csvへ保存
require 'csv'

class TestController < ApplicationController
  def categorize_and_save_news
    good_news = []
    bad_news = []

    feedback_data = CSV.read('public/csv/feedback/keyword_survey.csv', headers: true)

    feedback_data.each do |row|
      keyword = row['keyword']
      judge = row['judge'].to_i

      if judge == 1
        categorize_news('public/csv/good_news.csv', keyword, good_news)
      end
      
      if judge == 1
        categorize_news('public/csv/bad_news.csv', keyword, bad_news)
      end
    end

    save_news_to_csv('public/csv/fill/good_news_with_keyword.csv', good_news)
    save_news_to_csv('public/csv/fill/bad_news_with_keyword.csv', bad_news)
  end

  private

  def categorize_news(csv_file_path, keyword, categorized_news)
    data = CSV.read(csv_file_path, headers: true)

    data.each do |row|
      title = row['Title'].to_s
      description = row['Description'].to_s

      if title.include?(keyword) || description.include?(keyword)
        categorized_news << row.to_h.merge('Category' => row['Category'])
      end
    end
  end

  def save_news_to_csv(csv_file_path, news)
    CSV.open(csv_file_path, 'w') do |csv|
      csv << ['Category', 'Title', 'Description', 'URL'] # ヘッダーを書き込み

      news.each do |row|
        csv << [row['Category'], row['Title'], row['Description'], row['URL']]
      end
    end
  end
end