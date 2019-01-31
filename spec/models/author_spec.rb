require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'relationships' do
    it {should have_many :book_authors}
    it {should have_many(:books).through(:book_authors)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
  end
end
