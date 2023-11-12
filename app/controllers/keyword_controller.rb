# app/controllers/keyword_controller.rb
class KeywordController < ApplicationController
  KEYWORDS = [
    "投資",
    "スタートアップ",
    "企業",
    "マーケット",
    "経済",
    "映画",
    "音楽",
    "芸能",
    "テレビ番組",
    "芸術",
    "栄養",
    "フィットネス",
    "メンタル",
    "健康",
    "医療技術",
    "宇宙研究",
    "遺伝学",
    "環境",
    "脳",
    "物理",
    "サッカー",
    "バスケット",
    "野球",
    "オリンピック",
    "テニス",
    "人工知能",
    "セキュリティ",
    "拡張現実",
    "IoT",
    "ブロックチェーン"
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
