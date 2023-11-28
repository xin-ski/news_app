require 'treat'

include Treat::Core::DSL

# テキストの読み込み
text = 'これはキーワード抽出のためのサンプルテキストです。RubyのTreatを使用しています。'

# トークン化
doc = document(text)

# 形態素解析 (この部分はMeCabや他の形態素解析器を使用することも可能)
doc.apply(:chunk, :segment, :tokenize)

# キーワード抽出
keywords = doc.keywords

# 結果の表示
keywords.each do |keyword|
  puts keyword.to_s
end