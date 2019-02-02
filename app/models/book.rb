class Book < ApplicationRecord
  has_many  :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews

  validates_presence_of :title, :year, :authors, :cover_image
  validates :length, presence: true, numericality: {
    greater_than_or_equal_to: 0 }
  validates :title, uniqueness: { case_sensitive: false }

end
