require "rails_helper"

describe 'books_index' do
  it "user_can_see_all_books" do
    author_2 = Author.create(name: "Jane Doe")
    book_1 = author_2.books.create(title: "Book 1 Title", length: 111, year: 1111)
    book_2 = author_2.books.create(title: "Book 2 Title", length: 222, year: 2222)

    visit "/books"
    # save_and_open_page
    expect(page).to have_content("Books")
    expect(page).to have_content("Title: Book 1 Title")
    expect(page).to have_content("Length: 111")
    expect(page).to have_content("Year: 1111")
    expect(page).to have_content("Author(s):\nJane Doe")
    expect(page).to have_content("Book 2 Title")
    expect(page).to have_content("222")
    expect(page).to have_content("2222")
    expect(page).to have_content("Jane Doe")
  end
end
