class Book < ApplicationRecord
  has_many :bookshelves, dependent: :destroy # 「1つの本が複数の本棚に存在できる」という1対多の関係
  has_many :users, through: :bookshelves # 1つの本が複数のユーザーに所有されうる

  validates :title, presence: true, length: { maximum: 255 }
  validates :author, presence: true, length: { maximum: 255 }
  # Google BooksのAPIではISBN情報が正しく登録されてないことがあるので空欄でも許可
  validates :isbn, uniqueness: true, allow_blank: true
end
