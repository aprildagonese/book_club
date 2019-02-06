require "rails_helper"

describe 'on a book show page' do
  it "user can see the book's data" do
    author_1 = Author.create(name: "Jon Doe")
    author_2 = Author.create(name: "Jane Doe")
    book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, authors: [author_1], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")
    book_2 = Book.create(title: "Book 2 Title", length: 222, year: 2222, authors: [author_1, author_2], cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg")

    visit book_path(book_1)

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

  it "user can see review data" do
    author_1 = Author.create(name: "Jon Doe")
    book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, authors: [author_1], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")
    april = User.create(name: "April")
    rene = User.create(name: "Rene")
    review_1 = Review.create(title: "Review 1", description: "I liked this book", user: april, rating: 5, book: book_1)
    review_2 = Review.create(title: "Review 2", description: "I didn't like this book", user: rene, rating: 1, book: book_1)

    visit book_path(book_1)

    within "#review-#{review_1.id}" do
      expect(page).to have_content( "Review 1" )
      expect(page).to have_content( "I liked this book" )
      expect(page).to have_content( "April" )
      expect(page).to have_link("April", href: user_path(april))
      expect(page).to have_content( 5 )
    end
    within "#review-#{review_2.id}" do
      expect(page).to have_content( "Review 2" )
      expect(page).to have_content( "I didn't like this book" )
      expect(page).to have_content( "Rene" )
      expect(page).to have_link("Rene", href: user_path(rene))
      expect(page).to have_content( 1 )
    end
  end

  it "user can delete a book" do
    author_1 = Author.create(name: "Jon Doe")
    book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, authors: [author_1])
    book_2 = Book.create(title: "Book 2 Title", length: 222, year: 2222, authors: [author_1])
    april = User.create(name: "April")
    rene = User.create(name: "Rene")
    review_1 = Review.create(title: "Review 1", description: "I liked this book", user: april, rating: 5, book: book_1)
    review_2 = Review.create(title: "Review 2", description: "I didn't like this book", user: rene, rating: 1, book: book_1)
    review_3 = Review.create(title: "Review 3", description: "This book was ok", user: rene, rating: 3, book: book_2)

    expect(Author.count).to eq(1)
    expect(Book.count).to eq(2)
    expect(User.count).to eq(2)
    expect(Review.count).to eq(3)

    visit book_path(book_1)
    click_on("Delete This Book")

    expect(Author.count).to eq(1)
    expect(Book.count).to eq(1)
    expect(User.count).to eq(2)
    expect(Review.count).to eq(1)
  end

  it "user_can_see_statistics for book" do
    author_1 = Author.create(name: "John Smith")

    book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg", authors: [author_1])

    april = User.create(name: "April")
    rene = User.create(name: "Rene")
    ian = User.create(name: "Ian")
    megan = User.create(name: "Megan")
    tim = User.create(name: "Tim")
    teresa = User.create(name: "Teresa")
    trevor = User.create(name: "Trevor")
    julia = User.create(name: "Julia")

    review_1 = book_1.reviews.create(title: "Review 1", description: "I liked this book", user: april, rating: 4)
    review_2 = book_1.reviews.create(title: "Review 2", description: "so so", user: rene, rating: 1)
    review_3 = book_1.reviews.create(title: "Review 3", description: "Wow!", user: ian, rating: 4)
    review_4 = book_1.reviews.create(title: "Review 4", description: "As good as it gets!", user: megan, rating: 5)
    review_5 = book_1.reviews.create(title: "Review 5", description: "Mixed feelings", user: tim, rating:3)
    review_6 = book_1.reviews.create(title: "Review 6", description: "dfdfgsgfdgsggs", user: teresa, rating: 2)
    review_7 = book_1.reviews.create(title: "Review 7", description: "gsfgfgdsgsgfsgs", user: trevor, rating: 1)
    review_8 = book_1.reviews.create(title: "Review 8", description: "sgd hdfhsghf thshh", user: julia, rating: 3)

    visit book_path(book_1)

    within ".statistics-footer" do
      within ".statistics-column-1" do
        expect(page).to have_content("Top Reviews for this Book")
        expect(page).to have_content("#{review_4.title}")
        expect(page).to have_content("#{review_4.rating}")
        expect(page).to have_content("#{review_4.user.name}")
        expect(page).to have_content("#{review_1.title}")
        expect(page).to have_content("#{review_1.rating}")
        expect(page).to have_content("#{review_1.user.name}")
        expect(page).to have_content("#{review_3.title}")
        expect(page).to have_content("#{review_3.rating}")
        expect(page).to have_content("#{review_3.user.name}")
      end
      within ".statistics-column-2" do
        expect(page).to have_content("Lowest Reviews for this Book")
        expect(page).to have_content("#{review_2.title}")
        expect(page).to have_content("#{review_2.rating}")
        expect(page).to have_content("#{review_2.user.name}")
        expect(page).to have_content("#{review_7.title}")
        expect(page).to have_content("#{review_7.rating}")
        expect(page).to have_content("#{review_7.user.name}")
        expect(page).to have_content("#{review_6.title}")
        expect(page).to have_content("#{review_6.rating}")
        expect(page).to have_content("#{review_6.user.name}")
      end
      within ".statistics-column-3" do
        expect(page).to have_content("Average Rating for this Book")
        expect(page).to have_content(book_1.average_rating)
      end
    end
  end
end
