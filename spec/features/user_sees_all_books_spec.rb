require "rails_helper"

describe 'books_index' do
  it "user_can_see_all_books" do
    author_2 = Author.create(name: "Jane Doe")
    book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg", authors: [author_2])
    book_2 = Book.create(title: "Book 2 Title", length: 222, year: 2222, cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg", authors: [author_2])

    visit "/books"

    expect(page).to have_link("Add a New Book", href: new_book_path)

    within "#book-#{book_1.id}" do
      expect(page).to have_content("Title: Book 1 Title")
      expect(page).to have_content("Length: 111")
      expect(page).to have_content("Year: 1111")
      expect(page).to have_content("Author(s):\nJane Doe")
      expect(page).to have_link("Jane Doe", href: author_path(author_2))
      expect(page).to have_xpath("//img[contains(@src,'#{File.basename(book_1.cover_image)}')]")
    end

    within "#book-#{book_2.id}" do
      expect(page).to have_content("Book 2 Title")
      expect(page).to have_content("Length: 222")
      expect(page).to have_content("Year: 2222")
      expect(page).to have_content("Author(s):\nJane Doe")
      expect(page).to have_link("Jane Doe", href: author_path(author_2))
      expect(page).to have_xpath("//img[contains(@src,'#{File.basename(book_2.cover_image)}')]")
    end
  end
  it "user_can_see_area_showing_statistics" do

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
        expect(page).to have_content("Jennica:\n4")
        expect(page).to have_content("April:\n3")
        expect(page).to have_content("Rene>\n:3")
      end
    end
  end
end
