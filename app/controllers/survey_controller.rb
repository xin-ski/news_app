class SurveyController < ApplicationController
  def survey
  end

  def feedback
    selected_categories = params[:categories]

    feedback_csv = []

    # 選択されたカテゴリをCSVに追加
    categories = ['business', 'entertainment', 'health', 'general', 'science', 'sports', 'technology']
    categories.each do |category|
      if selected_categories.include?(category)
        feedback_csv << [category, 1]
      else
        feedback_csv << [category, 0]
      end
    end

    # フィードバックをCSVファイルとして保存
    CSV.open("public/csv/feedback/feedback.csv", "w") do |csv|
      csv << ["category", "survey"]
      feedback_csv.each { |row| csv << row }
    end

    redirect_to keyword_path
  end
end
