require "rails_helper"

describe 'on the new book page' do
  it 'stores new books' do
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

  it 'can store books with multiple authors' do
    visit new_book_path

    fill_in :book_title, with: "Good Omens"
    fill_in :book_length, with: 288
    fill_in :book_year, with: 1990
    fill_in :book_cover_image, with: "https://images-na.ssl-images-amazon.com/images/I/81Ig%2Br7RTKL.jpg"
    fill_in :book_authors, with: "Terry Pratchett, Neil Gaiman"

    click_on "Create Book"
    new_book = Book.last
    expected = "Author(s): #{new_book.authors.pluck(:name).join(" ")}"

    expect(current_path).to eq(book_path(new_book))

    visit book_path(new_book)

    expect(page).to have_content("Title: #{new_book.title}")
    expect(page).to have_content("Length: #{new_book.length}")
    expect(page).to have_content("Year: #{new_book.year}")
    expect(page).to have_xpath("//img[contains(@src,'#{File.basename(new_book.cover_image)}')]")
    expect(Author.count).to eq(2)
    expect(Book.count).to eq(1)

    new_book.authors.each do |author|
      expect(page).to have_content(expected)
    end
  end

  context 'when the author already exists in the database' do
    it 'does not duplicate the author' do
      austen = Author.create(name: "Jane Austen")
      pride_and_prejudice = Book.create(title: "Pride and Prejudice", year: 1813, length: 432, authors: [austen], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51sOyMmEYBL._SX310_BO1,204,203,200_.jpg")

      visit new_book_path

      fill_in :book_title, with: "Sense and Sensibility"
      fill_in :book_length, with: 352
      fill_in :book_year, with: 1811
      fill_in :book_cover_image, with: "https://images.gr-assets.com/books/1176166955l/600331.jpg"
      fill_in :book_authors, with: "Jane Austen"

      click_on "Create Book"

      expect(Author.count).to eq(1)
      expect(austen.books.count).to eq(2)
    end
  end

  context 'when no book cover image is provided' do
    it 'stores a default image' do
      visit new_book_path

      fill_in :book_title, with: "Sense and Sensibility"
      fill_in :book_length, with: 352
      fill_in :book_year, with: 1811
      fill_in :book_authors, with: "Jane Austen"

      click_on "Create Book"

      expected = "https://rmnetwork.org/newrmn/wp-content/uploads/2011/11/generic-book-cover.jpg"

      expect(page).to have_xpath("//img[contains(@src,'#{File.basename(expected)}')]")
    end
  end

end
