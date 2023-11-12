require 'csv'
# Ruby on Railsコントローラ内でPythonスクリプトを呼び出す例
class MainController < ApplicationController
  
  def main
    @good_categories, @bad_categories = categorize_feedback
    @good_news = load_news_for_categories(@good_categories, 2)
    @bad_news = load_news_for_categories(@bad_categories, 2)
  end
  

  private
  
  def categorize_feedback
    # feedback.csv ファイルを読み込み、好みのカテゴリと好みでないカテゴリを分類
    feedback_data = CSV.read('public/csv/feedback/feedback.csv', headers: true)

    good_categories = []
    bad_categories = []

    feedback_data.each do |row|
      category = row['category']
      survey = row['survey'].to_i

      if survey == 1
        good_categories << category
      elsif survey == 0
        bad_categories << category
      end
    end

    [good_categories, bad_categories]
  end

  def load_news_for_categories(categories, count)
    news = {}
  
    categories.each do |category|
      csv_file_path = "public/csv/category/#{category}_news.csv"
  
      if File.exist?(csv_file_path)
        data = CSV.read(csv_file_path, headers: true)
        data = data.drop(1)  # ヘッダーをスキップ
  
        random_news = data.to_a.shuffle.first(count)
  
        random_news.each do |news_item|
          news[category] ||= []
          news[category] << {
            'Title' => news_item[0],
            'Description' => news_item[1],
            'URL' => news_item[2]
          }
        end
      end
    end
    news
  end
  
  def save_to_csv
    @good_news = @good_news
    @bad_news =  @bad_news

    # データをCSVファイルに書き込む
    CSV.open('public/csv/saved_data.csv', 'w') do |csv|
      # ヘッダー行を書き込む（必要に応じて）
      csv << ['Category', 'Title', 'Description', 'URL']

      # データ行を書き込む
      @good_news.each do |category, news_items|
        news_items.each do |news|
          csv << [category, news['Title'], news['Description'], news['URL']]
        end
      end

      @bad_news.each do |category, news_items|
        news_items.each do |news|
          csv << [category, news['Title'], news['Description'], news['URL']]
        end
      end
    end

    # 成功メッセージなどの応答を返す（必要に応じて）
    redirect_to main_path, notice: 'データがCSVファイルに保存されました'
  end
end