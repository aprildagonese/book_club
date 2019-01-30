require "rails_helper"

describe 'books_index' do
  it "user_can_see_all_books" do
    author_2 = Author.create(name: "Jane Doe")
    book_1 = author_2.books.create(title: "Book 1 Title", length: 111, year: 1111, cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")
    book_2 = author_2.books.create(title: "Book 2 Title", length: 222, year: 2222, cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg")

    visit "/books"
    # save_and_open_page
    expect(page).to have_content("Books")
    expect(page).to have_content("Title: Book 1 Title")
    expect(page).to have_content("Length: 111")
    expect(page).to have_content("Year: 1111")
    expect(page).to have_content("Author(s):\nJane Doe")
    expect(page).to have_xpath("//img[contains(@src,'#{File.basename(book_1.cover_image)}')]")

    expect(page).to have_content("Book 2 Title")
    expect(page).to have_content("222")
    expect(page).to have_content("2222")
    expect(page).to have_content("Jane Doe")
    expect(page).to have_xpath("//img[contains(@src,'#{File.basename(book_2.cover_image)}')]")
  end
end
