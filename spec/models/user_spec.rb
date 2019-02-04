require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it {should have_many :reviews}
    it {should have_many(:books).through(:reviews)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'class methods' do
    context "generating statistics for books index page " do
      it "should get the 3 users with most reviews" do
        author_1 = Author.create(name: "John Smith")
        author_2 = Author.create(name: "Jane Doe")
        author_3 = Author.create(name: "Maria Calix")
        author_4 = Author.create(name: "Don Johnson")


        book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg", authors: [author_1])
        book_2 = Book.create(title: "Book 2 Title", length: 222, year: 2222, cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg", authors: [author_2])
        book_3 = Book.create(title: "Book 3 Title", length: 333, year: 3333, cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg", authors: [author_3])
        book_4 = Book.create(title: "Book 4 Title", length: 444, year: 4444, cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg", authors: [author_4])
        book_5 = Book.create(title: "Book 5 Title", length: 555, year: 5555, cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg", authors: [author_1])
        book_6 = Book.create(title: "Book 6 Title", length: 666, year: 6666, cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg", authors: [author_2])
        book_7 = Book.create(title: "Book 7 Title", length: 777, year: 7777, cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg", authors: [author_3])
        book_8 = Book.create(title: "Book 8 Title", length: 888, year: 8888, cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg", authors: [author_4])

        april = User.create(name: "April")
        rene = User.create(name: "Rene")
        ian = User.create(name: "Ian")
        megan = User.create(name: "Megan")
        jennica = User.create(name: "Jennica")


        review_1 = book_1.reviews.create(title: "Review 1", description: "I liked this book", user: april, rating: 4)
        review_2 = book_1.reviews.create(title: "Review 2", description: "so so", user: rene, rating: 1)
        review_3 = book_2.reviews.create(title: "Review 3", description: "Wow!", user: ian, rating: 4)
        review_4 = book_2.reviews.create(title: "Review 4", description: "As good as it gets!", user: rene, rating: 5)
        review_5 = book_3.reviews.create(title: "Review 5", description: "Mixed feelings", user: jennica, rating:1)
        review_6 = book_4.reviews.create(title: "Review 7", description: "dfdfgsgfdgsggs", user: jennica, rating: 2)
        review_7 = book_4.reviews.create(title: "Review 8", description: "gsfgfgdsgsgfsgs", user: april, rating: 1)
        review_8 = book_5.reviews.create(title: "Review 9", description: "sgd hdfhsghf thshh", user: rene, rating: 3)
        review_9 = book_6.reviews.create(title: "Review 10", description: "hhaddh lhhfjklae", user: jennica, rating: 3)
        review_10 = book_6.reviews.create(title: "Review 11", description: ";kdhualhfjlajfk", user: megan, rating: 5)
        review_11 = book_7.reviews.create(title: "Review 12", description: "ef lDFH LKHDLjkhd", user: april, rating: 5)
        review_12 = book_8.reviews.create(title: "Review 13", description: "akdjkulyrh jkdhk", user: jennica, rating: 2)

        expect(User.top_three_reviewers).to eq([jennica, april, rene])
      end
    end
  end
end
