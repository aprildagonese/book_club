require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'relationships' do
    it {should have_many :book_authors}
    it {should have_many(:authors).through(:book_authors)}
    it {should have_many :reviews}
    it {should have_many(:users).through(:reviews)}
  end

  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :year}
    it {should validate_presence_of :length}
    it { should validate_numericality_of(:length).is_greater_than_or_equal_to(0) }
  end

  describe 'intance methods' do
    context "in order to delete a book" do
      it "should delete the book's reviews" do
        author_1 = Author.create(name: "Jon Doe")
        author_2 = Author.create(name: "Jane Doe")
        book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, authors: [author_1], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")
        book_2 = Book.create(title: "Book 2 Title", length: 222, year: 2222, authors: [author_1, author_2], cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg")
        april = User.create(name: "April")
        review_1 = book_1.reviews.create(title: "Good book", description: "Liked it", rating: 4, user: april)
        review_2 = book_1.reviews.create(title: "Fine book", description: "Liked it enough", rating: 3, user: april)
        review_3 = book_2.reviews.create(title: "Boring book", description: "Didn't like it", rating: 2, user: april)

        expect(Review.count).to eq(3)

        book_1.delete_reviews(book_1.reviews)

        expect(book_1.reviews.count).to eq(0)
        expect(Review.count).to eq(1)
      end
    end

    context "generating statistics for books index page " do
      it "should calculate the average rating and total reviews for a book" do
        author_1 = Author.create(name: "John Smith")
        book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg", authors: [author_1])
        april = User.create(name: "April")
        rene = User.create(name: "Rene")
        jennica = User.create(name: "Jennica")
        book_1.reviews.create(title: "Review 1", description: "I liked this book", user: april, rating: 4)
        book_1.reviews.create(title: "Review 2", description: "so so", user: rene, rating: 3)
        book_1.reviews.create(title: "Review 3", description: "Wow!", user: jennica, rating: 5)

        expect(book_1.average_rating).to eq(4)
        expect(book_1.total_reviews).to eq(3)
      end

    it "should get the 3 highest rated book and 3 lowest rated books" do
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


      expect(Book.three_top_or_bottom_rated("DESC")).to eq([book_7,book_2,book_6])
      expect(Book.three_top_or_bottom_rated("ASC")).to eq([book_3, book_4, book_8])
    end

    it "should find the highest review for a book" do
      author_1 = Author.create(name: "Jon Doe")
      book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, authors: [author_1], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")
      april = User.create(name: "April")
      review_1 = book_1.reviews.create(title: "Good book", description: "Liked it", rating: 4, user: april)
      review_2 = book_1.reviews.create(title: "Fine book", description: "Liked it enough", rating: 3, user: april)
      review_3 = book_1.reviews.create(title: "Boring book", description: "Didn't like it", rating: 2, user: april)
      review_4 = book_1.reviews.create(title: "Great book", description: "It was wonderful!", rating: 5, user: april)

      expect(book_1.highest_review(book_1.reviews)).to eq(review_4)
    end
  end

end
