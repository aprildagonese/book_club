class ReviewsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    book = Book.find(params[:book_id])
    user = User.create(name: params[:review][:user])
    review = book.reviews.new(review_params)
    review.user = user
    review.save
    redirect_to book_path(book)
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])

    @review.title = params[:review][:title]
    @review.description = params[:review][:description]
    @review.rating = params[:review][:rating]
    @review.user = params[:review][:user]

    if @review.save
      redirect_to review_path(@review)
    else
      render :edit
    end
  end

  private

    def review_params
      params.require(:review).permit(:title, :description, :rating)
    end
  end
