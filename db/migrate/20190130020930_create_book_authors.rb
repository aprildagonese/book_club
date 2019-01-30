class CreateBookAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :book_authors do |t|
      t.integer :book_id
      t.integer :author_id
    end
  end
end
