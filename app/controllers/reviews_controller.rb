class ReviewsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    @book = Book.find(params[:book_id])
    @user = User.find_or_create_by(name: review_params[:user].titleize)
    @review = @book.reviews.create(title: review_params[:title], user: @user, rating: review_params[:rating], description: review_params[:description] )

    if @review.save
      flash[:success] = "Your review has been saved."
      redirect_to book_path(@book)
    else
      flash[:alert] = "Your review could not be saved. Please enter all required fields."
      redirect_to new_book_review_path(@book)
    end
  end

  def destroy
    review = Review.find_by(id: params[:review])
    user = User.find_by(id: params[:id])
    review.destroy
    redirect_to user_path(user)
  end

  private

    def review_params
      params.require(:review).permit(:title, :description, :rating, :user)
    end
  end
