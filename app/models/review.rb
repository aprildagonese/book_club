class Review < ApplicationRecord
  belongs_to :books
  belongs_to :users

  validates_presence_of :title, :user_id, :description, :book_id
  validates :rating, presence: true, numericality: {
    greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
