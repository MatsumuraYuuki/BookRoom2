class RemoveUniqueIndexFromBooksIsbn < ActiveRecord::Migration[7.0]
  def change
    # ISBNを削除
    # GoogleBooksAPIから取得した一部の書籍ではISBNが空文字列("")となることがあり、
    # ユニーク制約により2冊目以降の空ISBN書籍が登録できない問題があったため
    remove_index :books, :isbn

    # 新しくユニーク制約なしの通常のインデックスを追加。
    # Bookモデルでuniqueness: trueをし、そっちの方でユニーク性を維持
    add_index :books, :isbn
  end
end
