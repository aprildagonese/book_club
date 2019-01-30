class Book < ApplicationRecord
  has_many  :book_authors
  has_many :authors, through: :book_authors

  validates_presence_of :title, :year, :authors, :cover_image, :length
  validates :length, presence: true, numericality: {
    greater_than_or_equal_to: 0 }
end
