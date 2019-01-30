require "rails_helper"

describe 'books_index' do
  it "user_can_see_all_books" do
    book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111)
    book_2 = Book.create(title: "Book 2 Title", length: 222, year: 2222)

    visit "/books"

    save_and_open_page

    expect(page).to have_content("Books")
    expect(page).to have_content("Title: #{book_1.title}")
    expect(page).to have_content("Length: #{book_1.length}")
    expect(page).to have_content("Year: #{book_1.year}")
    expect(page).to have_content(book_2.title)
    expect(page).to have_content(book_2.length)
    expect(page).to have_content(book_2.year)
  end
end
