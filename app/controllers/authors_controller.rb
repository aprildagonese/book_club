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

end
