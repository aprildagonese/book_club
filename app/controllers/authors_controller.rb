class AuthorsController < ApplicationController
  def show
    @author = Author.find_by(id: params[:id])
  end

  def new
  end

  def create
    author = Author.new(params)
    author.save
  end

  def destroy
    author = Author.find_by(id: params[:id])
    author.delete_books(author.books)
    author.destroy
    redirect_to books_path
  end

end
