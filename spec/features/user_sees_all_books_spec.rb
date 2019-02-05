require "rails_helper"

describe 'the books index' do
  it "should show all books" do
    author_2 = Author.create(name: "Jane Doe")
    book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg", authors: [author_2])
    book_2 = Book.create(title: "Book 2 Title", length: 222, year: 2222, cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg", authors: [author_2])
    april = User.create(name: "April")
    rene = User.create(name: "Rene")
    ian = User.create(name: "Ian")
    megan = User.create(name: "Megan")
    jennica = User.create(name: "Jennica")
    review_1 = book_1.reviews.create(title: "Review 1", description: "I liked this book", user: april, rating: 4)
    review_2 = book_1.reviews.create(title: "Review 2", description: "so so", user: rene, rating: 1)
    review_3 = book_2.reviews.create(title: "Review 3", description: "Wow!", user: megan, rating: 4)
    review_4 = book_2.reviews.create(title: "Review 4", description: "As good as it gets!", user: ian, rating: 5)
    review_5 = book_2.reviews.create(title: "Review 5", description: "It was ok...", user: jennica, rating: 3)

    visit "/books"

    expect(page).to have_link("Add a New Book", href: new_book_path)

    within "#book-#{book_1.id}" do
      expect(page).to have_content("Book 1 Title")
      expect(page).to have_link("#{book_1.title}", href: book_path(book_1))
      expect(page).to have_content("Average Rating: 2.5")
      expect(page).to have_content("Total Reviews: 2")
      expect(page).to have_content("Length: 111")
      expect(page).to have_content("Year: 1111")
      expect(page).to have_content("Author(s):\nJane Doe")
      expect(page).to have_link("Jane Doe", href: author_path(author_2))
      expect(page).to have_xpath("//img[contains(@src,'#{File.basename(book_1.cover_image)}')]")
    end

    within "#book-#{book_2.id}" do
      expect(page).to have_content("Book 2 Title")
      expect(page).to have_link("#{book_2.title}", href: book_path(book_2))
      expect(page).to have_content("Average Rating: 4.0")
      expect(page).to have_content("Total Reviews: 3")
      expect(page).to have_content("Length: 222")
      expect(page).to have_content("Year: 2222")
      expect(page).to have_content("Author(s):\nJane Doe")
      expect(page).to have_link("Jane Doe", href: author_path(author_2))
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

    visit "/books"
    # save_and_open_page

    within ".statistics-footer" do
      within ".statistics-column-1" do
        expect(page).to have_content("Top Rated Books")
        expect(page).to have_content("#{book_7.title}: #{book_7.average_rating}")
        expect(page).to have_content("#{book_2.title}: #{book_2.average_rating}")
        expect(page).to have_content("#{book_6.title}: #{book_6.average_rating}")
      end
      within ".statistics-column-2" do
        expect(page).to have_content("Lowest Rated Books")
        expect(page).to have_content("#{book_3.title}: #{book_3.average_rating}")
        expect(page).to have_content("#{book_4.title}: #{book_4.average_rating}")
        expect(page).to have_content("#{book_8.title}: #{book_8.average_rating}")
      end
      within ".statistics-column-3" do
        expect(page).to have_content("Users With Most Reviews")
        expect(page).to have_content("Jennica: 4")
        expect(page).to have_content("April: 3")
        expect(page).to have_content("Rene: 3")
      end
    end
  end

  context "when user clicks on sort by Average Rating ascending" do
    it "should sort books by average ratings in ascending order" do
      author_1 = Author.create(name: "John Smith")
      author_2 = Author.create(name: "Jane Doe")
      author_3 = Author.create(name: "Maria Calix")
      author_4 = Author.create(name: "Don Johnson")


      book_1 = Book.create(title: "Book 1 Title", length: 500, year: 1111, cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg", authors: [author_1])
      book_2 = Book.create(title: "Book 2 Title", length: 100, year: 2222, cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg", authors: [author_2])
      book_3 = Book.create(title: "Book 3 Title", length: 600, year: 3333, cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg", authors: [author_3])
      book_4 = Book.create(title: "Book 4 Title", length: 300, year: 4444, cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg", authors: [author_4])
      book_5 = Book.create(title: "Book 5 Title", length: 200, year: 5555, cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg", authors: [author_1])
      book_6 = Book.create(title: "Book 6 Title", length: 400, year: 6666, cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg", authors: [author_2])

      april = User.create(name: "April")
      rene = User.create(name: "Rene")
      ian = User.create(name: "Ian")
      megan = User.create(name: "Megan")
      jennica = User.create(name: "Jennica")


      review_1 = book_1.reviews.create(title: "Review 1", description: "I liked this book", user: april, rating: 4)
      review_2 = book_1.reviews.create(title: "Review 2", description: "so so", user: rene, rating: 1)
      review_3 = book_1.reviews.create(title: "Review 3", description: "Wow!", user: ian, rating: 4)
      review_4 = book_2.reviews.create(title: "Review 4", description: "As good as it gets!", user: rene, rating: 5)
      review_5 = book_3.reviews.create(title: "Review 5", description: "Mixed feelings", user: jennica, rating:1)
      review_6 = book_4.reviews.create(title: "Review 6", description: "dfdfgsgfdgsggs", user: jennica, rating: 2)
      review_7 = book_4.reviews.create(title: "Review 7", description: "gsfgfgdsgsgfsgs", user: april, rating: 1)
      review_8 = book_4.reviews.create(title: "Review 8", description: "sgd hdfhsghf thshh", user: rene, rating: 3)
      review_9 = book_4.reviews.create(title: "Review 9", description: "hhaddh lhhfjklae", user: jennica, rating: 3)
      review_10 = book_5.reviews.create(title: "Review 10", description: ";kdhualhfjlajfk", user: megan, rating: 5)
      review_11 = book_5.reviews.create(title: "Review 11", description: "ef lDFH LKHDLjkhd", user: april, rating: 4)
      review_12 = book_6.reviews.create(title: "Last Review", description: "akdjkulyrh jkdhk", user: jennica, rating: 2)

      visit "/books"
      click_on "Average Rating - ascending"

      ithin "#book-#{book_1.id}" do
        expect(page).to have_content("Book 1 Title")
        expect(page).to have_link("#{book_1.title}", href: book_path(book_1))
        expect(page).to have_content("Average Rating: 2.5")
        expect(page).to have_content("Total Reviews: 2")
        expect(page).to have_content("Length: 111")
        expect(page).to have_content("Year: 1111")
        expect(page).to have_content("Author(s):\nJane Doe")
        expect(page).to have_link("Jane Doe", href: author_path(author_2))
        expect(page).to have_xpath("//img[contains(@src,'#{File.basename(book_1.cover_image)}')]")
      end

      within "#book-#{book_2.id}" do
        expect(page).to have_content("Book 2 Title")
        expect(page).to have_link("#{book_2.title}", href: book_path(book_2))
        expect(page).to have_content("Average Rating: 4.0")
        expect(page).to have_content("Total Reviews: 3")
        expect(page).to have_content("Length: 222")
        expect(page).to have_content("Year: 2222")
        expect(page).to have_content("Author(s):\nJane Doe")
        expect(page).to have_link("Jane Doe", href: author_path(author_2))
        expect(page).to have_xpath("//img[contains(@src,'#{File.basename(book_2.cover_image)}')]")
      end
      expect(Book.sort_books_by("average_rating", "ASC")).to eq([book_3,book_6,book_4,book_1,book_5,book_2])
      expect(Book.sort_books_by("average_rating", "DESC")).to eq([book_2,book_5,book_1,book_4,book_6,book_3])
      expect(Book.sort_books_by("length", "ASC")).to eq([book_2,book_5,book_4,book_6,book_1,book_3])
      expect(Book.sort_books_by("length", "DESC")).to eq([book_3,book_1,book_6,book_4,book_5,book_2])
      expect(Book.sort_books_by("reviews_count", "ASC")).to eq([book_2,book_3,book_6,book_5,book_1,book_4])
      expect(Book.sort_books_by("reviews_count", "DESC")).to eq([book_4,book_1,book_5,book_2,book_3,book_6])
    end
  end
end
