class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
  end

  def index
    @books = Book.all
  end

  def create
    author = Author.find_by(name: params[:author])
    book = Book.new(book_params)
    review.user = user
    review.save
    redirect_to book_path(book)
  end

private

  def book_params
    params.permit(:title, :length, :year, :cover_image, :author)
  end

  #require(:author).
end
