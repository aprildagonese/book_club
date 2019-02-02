require "rails_helper"

describe 'books_index' do
  it "user_can_see_all_books" do
    author_2 = Author.create(name: "Jane Doe")
    book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg", authors: [author_2])
    book_2 = Book.create(title: "Book 2 Title", length: 222, year: 2222, cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg", authors: [author_2])

    visit "/books"
    # save_and_open_page
    # binding.pry

    within "#book-#{book_1.id}" do
      expect(page).to have_content("Title: Book 1 Title")
      expect(page).to have_content("Length: 111")
      expect(page).to have_content("Year: 1111")
      expect(page).to have_content("Author(s):\nJane Doe")
      expect(page).to have_xpath("//img[contains(@src,'#{File.basename(book_1.cover_image)}')]")
    end

    within "#book-#{book_2.id}" do
      expect(page).to have_content("Book 2 Title")
      expect(page).to have_content("Length: 222")
      expect(page).to have_content("Year: 2222")
      expect(page).to have_content("Author(s):\nJane Doe")
      expect(page).to have_xpath("//img[contains(@src,'#{File.basename(book_2.cover_image)}')]")
    end
  end

  it "user_can_see_area_showing_statistics" do
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


    review_1 = Review.create(title: "Review 1", description: "I liked this book", user: april, rating: 4, book: book_1)
    review_2 = Review.create(title: "Review 2", description: "so so", user: rene, rating: 1, book: book_1)
    review_3 = Review.create(title: "Review 3", description: "Wow!", user: ian, rating: 4, book: book_2)
    review_4 = Review.create(title: "Review 4", description: "As good as it gets!", user: rene, rating: 5, book: book_2)
    review_5 = Review.create(title: "Review 5", description: "Mixed feelings", user: jennica, rating:1 , book: book_3)
    review_6 = Review.create(title: "Review 7", description: "dfdfgsgfdgsggs", user: jennica, rating: 2, book: book_4)
    review_7 = Review.create(title: "Review 8", description: "gsfgfgdsgsgfsgs", user: april, rating: 1, book: book_4)
    review_8 = Review.create(title: "Review 9", description: "sgd hdfhsghf thshh", user: rene, rating: 3, book: book_5)
    review_9 = Review.create(title: "Review 10", description: "hhaddh lhhfjklae", user: jennica, rating: 3, book: book_6)
    review_10 = Review.create(title: "Review 11", description: ";kdhualhfjlajfk", user: megan, rating: 5, book: book_6)
    review_11 = Review.create(title: "Review 12", description: "ef lDFH LKHDLjkhd", user: april, rating: 5, book: book_7)
    review_12 = Review.create(title: "Review 13", description: "akdjkulyrh jkdhk", user: jennica, rating: 2, book: book_8)

    visit "/books"
    # save_and_open_page

    within ".statistics-footer" do
      within ".statistics-column-1" do
        expect(page).to have_content("Top Rated Books")
        expect(page).to have_content("Book 7 Title:\n5.0")
        expect(page).to have_content("Book 2 Title:\n4.5")
        expect(page).to have_content("Book 6 Title:\n4.0")
      end
      within ".statistics-column-2" do
        expect(page).to have_content("Lowest Rated Books")
        expect(page).to have_content("Book 8 Title:\n2.0")
        expect(page).to have_content("Book 4 Title\n1.5")
        expect(page).to have_content("Book 3 Title:\n1.0")
      end
      within ".statistics-column-3" do
        expect(page).to have_content("Users With Most Reviews")
        expect(page).to have_content("Jannica:\n4")
        expect(page).to have_content("April:\n3")
        expect(page).to have_content("Rene>\n:3")
      end
    end
  end
end
