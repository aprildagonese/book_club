require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'relationships' do
    it {should have_many :book_authors}
    it {should have_many(:authors).through(:book_authors)}
  end

  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :year}
    it {should validate_presence_of :authors}
    it {should validate_presence_of :length}
    it {should validate_presence_of :cover_image}
    it { should validate_numericality_of(:length).is_greater_than_or_equal_to(0) }
  end
end
