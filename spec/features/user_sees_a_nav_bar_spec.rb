require "rails_helper"

describe 'all pages' do
  it "should show a nav bar" do
    author_2 = Author.create(name: "Jane Doe")
    book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg", authors: [author_2])

    visit books_path

    within ".nav-bar" do
      expect(page).to have_link("Home", href: root_path)
      expect(page).to have_link("All Books", href: books_path)
    end

    visit author_path(author_2)

    within ".nav-bar" do
      expect(page).to have_link("Home", href: root_path)
      expect(page).to have_link("All Books", href: books_path)
    end
  end
end
