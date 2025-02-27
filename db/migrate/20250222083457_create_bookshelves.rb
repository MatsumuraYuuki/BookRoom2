class CreateBookshelves < ActiveRecord::Migration[7.0]
  def change
    create_table :bookshelves do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end
    add_index :bookshelves, [:user_id, :book_id], unique: true
  end
end
