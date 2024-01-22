# app/controllers/keyword_controller.rb
class KeywordController < ApplicationController
  KEYWORDS = [
    "金融",
    "経営",
    "ベンチャー",
    "イノベーション",
    "ビジネス",
    "映画",
    "音楽",
    "芸能",
    "テレビ",
    "アート",
    "フィットネス",
    "メンタル",
    "食事",
    "医療",
    "予防",
    "一般",
    "ニュース",
    "トピック",
    "情報",
    "世間",
    "宇宙",
    "科学",
    "AI",
    "ロボ",
    "バイオ",
    "サッカー",
    "バスケ",
    "野球",
    "オリンピック",
    "テニス",
    "IT",
    "デジタル",
    "技術",
    "クラウド",
    "サイバー"
    # 他のキーワードをリストに追加
  ]

  def keyword
    # キーワードアンケートを表示
  end

  def save_survey
    selected_keywords = params[:keywords] || []

    # CSVに保存するロジックをここに実装
    csv_data = []
    KeywordController::KEYWORDS.each do |keyword|
      csv_data << [keyword, selected_keywords.include?(keyword) ? 1 : 0]
    end

    # CSVファイルに保存
    CSV.open("public/csv/feedback/keyword_survey.csv", "w") do |csv|
      csv << ["keyword", "judge"]
      csv_data.each { |row| csv << row }
    end

    redirect_to root_path, notice: "アンケートが送信されました。"
  end
end
