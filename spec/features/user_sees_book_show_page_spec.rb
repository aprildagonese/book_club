require "rails_helper"

describe 'book_show_page' do
  it "user_can_see_book_data" do
    author_1 = Author.create(name: "Jon Doe")
    author_2 = Author.create(name: "Jane Doe")
    book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, authors: [author_1], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")
    book_2 = Book.create(title: "Book 2 Title", length: 222, year: 2222, authors: [author_1, author_2], cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg")

    visit book_path(book_1)

    # save_and_open_page
    # require 'pry'; binding.pry
    expect(page).to have_content( "#{book_1.title}" )
    expect(page).to have_content("Length: #{book_1.length}")
    expect(page).to have_content("Year: #{book_1.year}")
    expect(page).to have_xpath("//img[contains(@src,'#{File.basename(book_1.cover_image)}')]")

    expect(page).to_not have_content("Title: #{book_2.title}")
    expect(page).to_not have_content("Length: #{book_2.length}")
    expect(page).to_not have_content("Year: #{book_2.year}")
    expect(page).to_not have_content("#{author_2.name}")
    expect(page).to_not have_xpath("//img[contains(@src,'#{File.basename(book_2.cover_image)}')]")
  end

  it "user_can_see_review_data" do
    author_1 = Author.create(name: "Jon Doe")
    book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, authors: [author_1], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")
    april = User.create(name: "April")
    rene = User.create(name: "Rene")
    review_1 = Review.create(title: "Review 1", description: "I liked this book", user: april, rating: 5, book: book_1)
    review_2 = Review.create(title: "Review 2", description: "I didn't like this book", user: rene, rating: 1, book: book_1)

    visit book_path(book_1)

    expect(page).to have_content( "Review 1" )
    expect(page).to have_content( "I liked this book" )
    expect(page).to have_content( "April" )
    expect(page).to have_content( 5 )

    expect(page).to have_content( "Review 2" )
    expect(page).to have_content( "I didn't like this book" )
    expect(page).to have_content( "Rene" )
    expect(page).to have_content( 1 )
  end


end
