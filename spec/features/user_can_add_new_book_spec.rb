require "rails_helper"

describe 'new_book' do
  it "user_can_add_new_book" do

    visit new_book_path

    fill_in :book_title, with: "Pride and Prejudice"
    fill_in :book_length, with: 432
    fill_in :book_year, with: 1813
    fill_in :book_cover_image, with: "https://images-na.ssl-images-amazon.com/images/I/51sOyMmEYBL._SX310_BO1,204,203,200_.jpg"
    fill_in :book_author, with: "Jane Austen"

    click_on "Create Book"

    new_book = Book.last

    expect(current_path).to eq(book_path(new_book))

    visit book_path(new_book)

    expect(page).to have_content("Title: #{new_book.title}")
    expect(page).to have_content("Length: #{new_book.length}")
    expect(page).to have_content("Year: #{new_book.year}")
    expect(page).to have_content("Author(s):\n#{new_book.authors}")
    expect(page).to have_xpath("//img[contains(@src,'#{File.basename(new_book.cover_image)}')]")
  end

end
