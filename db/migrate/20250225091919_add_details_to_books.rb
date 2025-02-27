class AddDetailsToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :published_date, :date
    add_column :books, :thumbnail_url, :string
    add_column :books, :publisher, :string
  end
end
