require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'relationships' do
    it {should have_many :book_authors}
    it {should have_many(:authors).through(:book_authors)}
    it {should have_many :reviews}
  end

  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :year}
    it {should validate_presence_of :length}
    it { should validate_numericality_of(:length).is_greater_than_or_equal_to(0) }
  end

  describe 'intance methods' do
    context "deleting a book" do
      it "should delete the book's reviews" do
        author_1 = Author.create(name: "Jon Doe")
        author_2 = Author.create(name: "Jane Doe")
        book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, authors: [author_1], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")
        book_2 = Book.create(title: "Book 2 Title", length: 222, year: 2222, authors: [author_1, author_2], cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg")
        user = User.create(name: "April")
        review_1 = book_1.reviews.create(title: "Good book", description: "Liked it", rating: 4, user: user)
        review_2 = book_1.reviews.create(title: "Fine book", description: "Liked it enough", rating: 3, user: user)
        review_3 = book_2.reviews.create(title: "Boring book", description: "Didn't like it", rating: 2, user: user)

        expect(Review.count).to eq(3)

        book_1.delete_reviews(book_1.reviews)

        expect(book_1.reviews.count).to eq(0)
        expect(Review.count).to eq(1)
      end
    end
  end
end
