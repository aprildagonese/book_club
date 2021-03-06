class Book < ApplicationRecord
  has_many  :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews
  has_many :users, through: :reviews

  validates_presence_of :title, :year, :authors
  validates :length, presence: true, numericality: {
    greater_than_or_equal_to: 0 }
  validates :title, uniqueness: { case_sensitive: false }

  def delete_reviews(reviews)
    reviews.each do |review|
      review.delete
    end
  end

  def average_rating
    reviews.average(:rating).to_f.round(1)
  end

  def total_reviews
    reviews.count
  end

  def self.sort_books_by(column, direction, number = Book.count)
    if column == "length"
      order("#{column} #{direction}")
    else
      Book.sort_by_review(column, direction, number)
    end
  end

  def self.sort_by_review(column, direction, number)
    Book.joins(:reviews)
    .select('books.*, avg(reviews.rating) as average_rating, count(reviews) as reviews_count')
    .group("id")
    .order("#{column} #{direction}, title")
    .limit(number)
  end

  def three_top_or_bottom_reviews(direction)
    reviews.order("rating #{direction}").limit(3)
  end

  def highest_review(reviews)
    reviews.max_by(&:rating)
  end

end
