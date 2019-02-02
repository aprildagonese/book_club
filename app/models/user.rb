class User < ApplicationRecord
  has_many :reviews

  validates_presence_of :name
  validates :name, uniqueness: { case_sensitive: false }

end
