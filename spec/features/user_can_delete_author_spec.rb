require "rails_helper"

describe "on an author show page" do
  context "when a book has one author" do
    it "user can delete that author and her books" do
      author_1 = Author.create(name: "Jon Doe")
      author_2 = Author.create(name: "Jane Doe")
      book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, authors: [author_1], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")
      book_2 = Book.create(title: "Book 2 Title", length: 222, year: 2222, authors: [author_1, author_2], cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg")

      expect(Author.count).to eq(2)
      expect(Book.count).to eq(2)

      visit author_path(author_1)
      click_on "Delete This Author"

      expect(current_path).to eq(books_path)
      expect(Author.count).to eq(1)
      expect(Book.count).to eq(0)
    end
  end

  context "when a book has two authors" do
    it "user deletes book, but other author remains" do
      author_1 = Author.create(name: "Jon Doe")
      author_2 = Author.create(name: "Jane Doe")
      book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, authors: [author_1], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")
      book_2 = Book.create(title: "Book 2 Title", length: 222, year: 2222, authors: [author_1, author_2], cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg")

      expect(Author.count).to eq(2)
      expect(Book.count).to eq(2)

      visit author_path(author_2)
      click_on "Delete This Author"

      expect(current_path).to eq(books_path)
      expect(Author.count).to eq(1)
      expect(Book.count).to eq(1)
    end
  end

end
