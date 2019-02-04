class User < ApplicationRecord
  has_many :reviews
  has_many :books, through: :reviews


  validates_presence_of :name
  validates :name, uniqueness: { case_sensitive: false }

  def self.top_three_reviewers
    User.joins(:reviews)
    .select('users.*, count(reviews.id) as reviews_count')
    .group("id")
    .order("reviews_count DESC")
    .limit(3)
  end

end
