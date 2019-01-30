require "rails_helper"

describe 'author_show_page' do
  it "user_can_see_author_books_data" do
    author_1 = Author.create(name: "Jon Doe")
    author_2 = Author.create(name: "Jane Doe")
    book_1 = author_1.books.create(title: "Book 1 Title", length: 111, year: 1111, author_id: author_1)
    book_2 = author_1.books.create(title: "Book 2 Title", length: 222, year: 2222, author_id: [author_1, author_2])

    visit "/authors/#{author_1.id}"

    save_and_open_page
    # require 'pry'; binding.pry
    expect(page).to have_content("#{author_1.name}")
    expect(page).to have_content("Title: #{book_1.title}")
    expect(page).to have_content("Length: #{book_1.length}")
    expect(page).to have_content("Year: #{book_1.year}")
    expect(page).to have_content("Title: #{book_2.title}")
    expect(page).to have_content("Length: #{book_2.length}")
    expect(page).to have_content("Year: #{book_2.year}")
    expect(page).to have_content("Co-Author: #{author_2.name}")
  end
end
