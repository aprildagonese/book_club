class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if params[:sort] == "desc"
      @reviews = @user.reviews.order(created_at: :desc)
    elsif params[:sort] == "asc"
      @reviews = @user.reviews.order(:created_at)
    else
      @reviews = @user.reviews
    end
  end

  def new
  end

  def create
  end
end
