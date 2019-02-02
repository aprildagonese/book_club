require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'relationships' do
    it {should have_many :book_authors}
    it {should have_many(:books).through(:book_authors)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'intance methods' do
    context "deleting an author" do
      it "should delete a book when it has only one author" do
        author_1 = Author.create(name: "Jon Doe")
        author_2 = Author.create(name: "Jane Doe")
        book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, authors: [author_1], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")
        book_2 = Book.create(title: "Book 2 Title", length: 222, year: 2222, authors: [author_1, author_2], cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg")

        expect(author_1.books.count).to eq(2)
        expect(Book.count).to eq(2)

        author_1.delete_books(author_1.books)

        expect(author_1.books.count).to eq(1)
        expect(Book.count).to eq(1)
      end

      it "should not delete a book when it has more than one author" do
        author_1 = Author.create(name: "Jon Doe")
        author_2 = Author.create(name: "Jane Doe")
        book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, authors: [author_1], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")
        book_2 = Book.create(title: "Book 2 Title", length: 222, year: 2222, authors: [author_1, author_2], cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg")

        expect(author_2.books.count).to eq(1)
        expect(Book.count).to eq(2)

        author_2.delete_books(author_2.books)

        expect(author_2.books.count).to eq(1)
        expect(Book.count).to eq(2)
      end
    end
  end

end
