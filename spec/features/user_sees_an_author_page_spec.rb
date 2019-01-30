require "rails_helper"

describe 'author_show_page' do
  it "user_can_see_author_books_data" do
    author_1 = Author.create(name: "Jon Doe")
    author_2 = Author.create(name: "Jane Doe")
    book_1 = author_1.books.create(title: "Book 1 Title", length: 111, year: 1111, cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")
    book_2 = Book.create(title: "Book 2 Title", length: 222, year: 2222, authors: [author_1, author_2], cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg")

    visit "/authors/#{author_1.id}"

    # save_and_open_page
    # require 'pry'; binding.pry
    expect(page).to have_content("#{author_1.name}")
    expect(page).to have_content("Title: #{book_1.title}")
    expect(page).to have_content("Length: #{book_1.length}")
    expect(page).to have_content("Year: #{book_1.year}")
    expect(page).to have_xpath("//img[contains(@src,'#{File.basename(book_1.cover_image)}')]")

    expect(page).to have_content("Title: #{book_2.title}")
    expect(page).to have_content("Length: #{book_2.length}")
    expect(page).to have_content("Year: #{book_2.year}")
    expect(page).to have_content("Co-Author(s):\n#{author_2.name}")
    expect(page).to have_xpath("//img[contains(@src,'#{File.basename(book_2.cover_image)}')]")


  end
end
