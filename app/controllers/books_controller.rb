class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
  end

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(merged_params)
    @book.authors = params[:book][:authors].split(",").map do |author|
      Author.find_or_create_by(name: author.titleize.strip)
    end
    if @book.save
      redirect_to book_path(@book)
    else
      @authors = Author.all
      render :new
    end
  end

  def merged_params
    default_image = {:cover_image=>"https://rmnetwork.org/newrmn/wp-content/uploads/2011/11/generic-book-cover.jpg"}

    if params[:book][:cover_image] == ""
      book_params.merge(default_image)
    else
      book_params
    end
  end

private

  def book_params
    params.require(:book).permit(:title, :length, :year, :cover_image, :author)
  end
end
