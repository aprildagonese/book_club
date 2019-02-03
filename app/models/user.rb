class User < ApplicationRecord
  has_many :reviews
  has_many :books, through: :reviews


  validates_presence_of :name
  validates :name, uniqueness: { case_sensitive: false }

end
