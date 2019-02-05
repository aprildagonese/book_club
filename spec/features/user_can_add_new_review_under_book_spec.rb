require 'rails_helper'

RSpec.describe "on the New Review page", type: :feature do
  it "user can create a new review" do
    author_1 = Author.create(name: "Jon Doe")
    book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, authors: [author_1], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")

    visit new_book_review_path(book_1)

    fill_in :review_title, with: "Best Book Ever"
    fill_in :review_description, with: "I just can't explain how much I loved this book"
    fill_in :review_rating, with: 5
    fill_in :review_user, with: "April"

    click_on "Create Review"

    expect(current_path).to eq(book_path(book_1))

    visit book_path(book_1)

    expect(page).to have_content( "Best Book Ever" )
    expect(page).to have_content( "I just can't explain how much I loved this book" )
    expect(page).to have_content( "Book 1 Title" )
    expect(page).to have_content( 5 )
  end

  context 'when a new review is not correctly saved' do
    it 'user sees a flash alert' do
      author_1 = Author.create(name: "Jon Doe")
      book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, authors: [author_1], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")

      visit new_book_review_path(book_1)

      fill_in :review_title, with: "Best Book Ever"
      fill_in :review_description, with: "I just can't explain how much I loved this book"
      fill_in :review_user, with: "April"

      click_on "Create Review"

      expect(page).to have_content("Your review could not be saved.")
    end
  end
end
