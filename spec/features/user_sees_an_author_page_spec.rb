require "rails_helper"

describe 'author show page' do
  before :each do
    @author_1 = Author.create(name: "Jon Doe")
    @author_2 = Author.create(name: "Jane Doe")
    @book_1 = Book.create(title: "Book 1 Title", length: 111, year: 1111, authors: [@author_1], cover_image: "https://images-na.ssl-images-amazon.com/images/I/51jNORv6nQL._SX340_BO1,204,203,200_.jpg")
    @book_2 = Book.create(title: "Book 2 Title", length: 222, year: 2222, authors: [@author_1, @author_2], cover_image: "http://bookriotcom.c.presscdn.com/wp-content/uploads/2014/08/HP_hc_new_2-e1407533769415.jpeg")
  end

  it "user can see author books data" do
    visit "/authors/#{@author_1.id}"

    expect(page).to have_content("#{@author_1.name}")
    expect(page).to have_content("Title: #{@book_1.title}")
    expect(page).to have_content("Length: #{@book_1.length}")
    expect(page).to have_content("Year: #{@book_1.year}")
    expect(page).to have_xpath("//img[contains(@src,'#{File.basename(@book_1.cover_image)}')]")

    expect(page).to have_content("Title: #{@book_2.title}")
    expect(page).to have_content("Length: #{@book_2.length}")
    expect(page).to have_content("Year: #{@book_2.year}")
    expect(page).to have_content("Co-Author(s):\n#{@author_2.name}")
    expect(page).to have_xpath("//img[contains(@src,'#{File.basename(@book_2.cover_image)}')]")
  end

  it "user doesn't see author's name under coauthored books" do
    visit "/authors/#{@author_1.id}"

    expect(page).to have_content("#{@author_1.name}", maximum: 1)
  end

  it "user sees top review for each book" do
    april = User.create(name: "April")
    review_1 = @book_1.reviews.create(title: "Good book", description: "Liked it", rating: 4, user: april)
    review_2 = @book_1.reviews.create(title: "Fine book", description: "Liked it enough", rating: 3, user: april)
    review_3 = @book_2.reviews.create(title: "Boring book", description: "Didn't like it", rating: 2, user: april)
    review_4 = @book_2.reviews.create(title: "Great book", description: "It was wonderful!", rating: 5, user: april)

    visit author_path(@author_1)

    within "#book-#{@book_1.id}" do
      expect(page).to have_content( "#{review_1.title}" )
      expect(page).to have_link("#{@book_1.title}", href: book_path(@book_1))
      expect(page).to have_content( "#{review_1.description}" )
      expect(page).to have_content( "Rating: #{review_1.rating}" )
      expect(page).to have_content( "#{review_1.user.name}" )
      expect(page).to have_link("April", href: user_path(april))
    end

    within "#book-#{@book_2.id}" do
      expect(page).to have_content( "#{review_4.title}" )
      expect(page).to have_link("#{@book_2.title}", href: book_path(@book_2))
      expect(page).to have_content( "#{review_4.description}" )
      expect(page).to have_content( "Rating: #{review_4.rating}" )
      expect(page).to have_content( "#{review_4.user.name}" )
      expect(page).to have_link("April", href: user_path(april))
    end
  end

  context "when there are no user reviews yet" do
    it "user sees a link to add a review" do
      visit author_path(@author_1)

      within "#book-#{@book_1.id}" do
        expect(page).to have_content("review this book!")
        expect(page).to have_link("review this book!", href: new_book_review_path(@book_1))
      end

      within "#book-#{@book_2.id}" do
        expect(page).to have_content("review this book!")
        expect(page).to have_link("review this book!", href: new_book_review_path(@book_2))
      end
    end
  end
end
