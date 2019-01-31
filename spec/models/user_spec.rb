require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'relationships' do
    it {should have_many :reviews}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
  end
end
