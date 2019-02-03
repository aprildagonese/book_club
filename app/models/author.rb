class Author < ApplicationRecord
  has_many  :book_authors
  has_many :books, through: :book_authors

  validates_presence_of :name
  validates :name, uniqueness: { case_sensitive: false }

  def delete_books(books)
    books.each do |book|
      book.delete_reviews(book.reviews)
      book.delete
    end
  end

end
