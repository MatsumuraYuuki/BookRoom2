class Bookshelf < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum :status, {
    want_to_read: 0,
    reading: 1,
    finished: 2
  }

  validates :status, presence: true
  validates :user_id, uniqueness: { scope: :book_id } # 同じ本を重複して登録できないように
end
