require "rails_helper"

describe 'on the user show page' do
  it "should show all user's reviews" do
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
    expect(page).to have_link("Newest First")
    expect(page).to have_link("Oldest First")

    expect(page).to have_content( "Review 1" )
    expect(page).to have_content( "I liked this book" )
    expect(page).to have_content( "Book 1 Title" )
    expect(page).to have_link("#{book_1.title}", href: book_path(book_1))
    expect(page).to have_content( 5 )
    expect(page).to have_content( "#{review_1.created_at}" )

    expect(page).to have_content( "Review 3" )
    expect(page).to have_content( "Book 2 was ok" )
    expect(page).to have_content( "Book 2 Title" )
    expect(page).to have_link("#{book_2.title}", href: book_path(book_2))
    expect(page).to have_content( 3 )
    expect(page).to have_content( "#{review_3.created_at}" )
  end
  context "when the user sorts by newest first" do
    it "should have descending chronological order" do
      author_1 = Author.create(name: "Jon Doe")
      book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, authors: [author_1], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")
      april = User.create(name: "April")
      review_1 = Review.create(title: "Review1", description: "I liked this book", user: april, rating: 5, book: book_1)
      review_2 = Review.create(title: "Review2", description: "I didn't like this book", user: april, rating: 1, book: book_1)
      review_3 = Review.create(title: "Review3", description: "Not bad at all", user: april, rating: 4, book: book_1)
      review_4 = Review.create(title: "Review4", description: "Not the best", user: april, rating: 2, book: book_1)

      visit user_path(april)
      click_on "Newest First"

      elements = all('#Review1, #Review2, #Review3, #Review4');
      expect(elements[0]['id']).to eql('Review4');
      expect(elements[1]['id']).to eql('Review3');
      expect(elements[2]['id']).to eql('Review2');
      expect(elements[3]['id']).to eql('Review1');
    end
  end
  context "when the user sorts by oldest first" do
    it "should have ascending chronological order" do
      author_1 = Author.create(name: "Jon Doe")
      book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, authors: [author_1], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")
      april = User.create(name: "April")
      review_1 = Review.create(title: "Review1", description: "I liked this book", user: april, rating: 5, book: book_1)
      review_2 = Review.create(title: "Review2", description: "I didn't like this book", user: april, rating: 1, book: book_1)
      review_3 = Review.create(title: "Review3", description: "Not bad at all", user: april, rating: 4, book: book_1)
      review_4 = Review.create(title: "Review4", description: "Not the best", user: april, rating: 2, book: book_1)

      visit user_path(april)
      click_on "Oldest First"

      elements = all('#Review1, #Review2, #Review3, #Review4');
      expect(elements[0]['id']).to eql('Review1');
      expect(elements[1]['id']).to eql('Review2');
      expect(elements[2]['id']).to eql('Review3');
      expect(elements[3]['id']).to eql('Review4');
    end
  end

  it "user can delete individual reviews" do
    author_1 = Author.create(name: "Jon Doe")
    book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, authors: [author_1], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")
    april = User.create(name: "April")
    review_1 = Review.create(title: "Review1", description: "I liked this book", user: april, rating: 5, book: book_1)
    review_2 = Review.create(title: "Review2", description: "I didn't like this book", user: april, rating: 1, book: book_1)
    review_3 = Review.create(title: "Review3", description: "Not bad at all", user: april, rating: 4, book: book_1)
    review_4 = Review.create(title: "Review4", description: "Not the best", user: april, rating: 2, book: book_1)

    visit user_path(april)

    expect(Review.count).to eq(4)
    expect(page).to have_content("Not bad at all")

    within "#Review3" do
      click_on "Delete This Review"
    end

    expect(current_path).to eq(user_path(april))
    expect(Review.count).to eq(3)
    expect(page).to_not have_content("Not bad at all")
    expect(page).to have_content("I didn't like this book")

    within "#Review2" do
      click_on "Delete This Review"
    end

    expect(Review.count).to eq(2)
    expect(page).to_not have_content("I didn't like this book")
    expect(current_path).to eq(user_path(april))
  end

end
