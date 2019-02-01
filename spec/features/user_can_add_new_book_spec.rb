require "rails_helper"

describe 'new_book' do
  it "user_can_add_new_book" do
    visit new_book_path

    fill_in :book_title, with: "Pride and Prejudice"
    fill_in :book_length, with: 432
    fill_in :book_year, with: 1813
    fill_in :book_cover_image, with: "https://images-na.ssl-images-amazon.com/images/I/51sOyMmEYBL._SX310_BO1,204,203,200_.jpg"
    fill_in :book_authors, with: "Jane Austen"

    click_on "Create Book"
    new_book = Book.last

    expect(current_path).to eq(book_path(new_book))

    visit book_path(new_book)

    expect(page).to have_content("Title: #{new_book.title}")
    expect(page).to have_content("Length: #{new_book.length}")
    expect(page).to have_content("Year: #{new_book.year}")
    expect(page).to have_xpath("//img[contains(@src,'#{File.basename(new_book.cover_image)}')]")

    new_book.authors.each do |author|
      expect(page).to have_content("Author(s): #{author.name}")
    end
  end

  it "user can add new book with multiple authors" do
    visit new_book_path

    fill_in :book_title, with: "Good Omens"
    fill_in :book_length, with: 666
    fill_in :book_year, with: 1892
    fill_in :book_cover_image, with: "https://images-na.ssl-images-amazon.com/images/I/81Ig%2Br7RTKL.jpg"
    fill_in :book_authors, with: "Terry Pratchett, Neil Gaiman"

    click_on "Create Book"
    new_book = Book.last
    expected = "Author(s): #{new_book.authors.pluck(:name).join(", ")}"

    expect(current_path).to eq(book_path(new_book))

    visit book_path(new_book)

    expect(page).to have_content("Title: #{new_book.title}")
    expect(page).to have_content("Length: #{new_book.length}")
    expect(page).to have_content("Year: #{new_book.year}")
    expect(page).to have_xpath("//img[contains(@src,'#{File.basename(new_book.cover_image)}')]")

    new_book.authors.each do |author|
      expect(page).to have_content(expected)
    end
  end
end
