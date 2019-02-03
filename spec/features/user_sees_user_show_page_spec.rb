require "rails_helper"

describe 'user_show_page' do
  it "user sees all user reviews" do
    author_1 = Author.create(name: "Jon Doe")
    author_2 = Author.create(name: "Jane Doe")
    book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, authors: [author_1], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")
    book_2 = Book.create(title: "Book 2 Title", length: 222, year: 2222, authors: [author_1, author_2], cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg")
    april = User.create(name: "April")
    rene = User.create(name: "Rene")
    review_1 = Review.create(title: "Review 1", description: "I liked this book", user: april, rating: 5, book: book_1)
    review_2 = Review.create(title: "Review 2", description: "I didn't like this book", user: rene, rating: 1, book: book_1)
    review_3 = Review.create(title: "Review 3", description: "Book 2 was ok", user: april, rating: 3, book: book_2)

    visit user_path(april)

    expect(page).to have_content("#{april.name}")
    expect(page).to have_link("Sort")

    expect(page).to have_content( "Review 1" )
    expect(page).to have_content( "I liked this book" )
    expect(page).to have_content( "Book 1 Title" )
    expect(page).to have_link("Title: Book 1 Title", href: book_path(book_1))
    expect(page).to have_content( 5 )
    expect(page).to have_content( "#{review_1.created_at}" )

    expect(page).to have_content( "Review 3" )
    expect(page).to have_content( "Book 2 was ok" )
    expect(page).to have_content( "Book 2 Title" )
    expect(page).to have_link("Title: Book 2 Title", href: book_path(book_2))
    expect(page).to have_content( 3 )
    expect(page).to have_content( "#{review_3.created_at}" )

  end
end
