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
    author = Author.find_or_create_by(name: params[:book][:authors])
    book = Book.new(book_params)
    book.authors = [author]
    book.save
    redirect_to book_path(book)
  end

private

  def book_params
    params.require(:book).permit(:title, :length, :year, :cover_image, :author)
  end
end
