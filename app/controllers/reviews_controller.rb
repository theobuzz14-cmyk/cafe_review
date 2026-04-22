class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:edit, :update, :destroy]

  def create
    @cafe = Cafe.find(params[:cafe_id])
    @review = @cafe.reviews.build(review_params)
    @review.user_name = current_user

    if @review.save
      redirect_to cafe_path(@cafe), notice: "レビューを投稿しました"
    else
      @reviews = @cafe.reviews.order(created_at: :desc)
      flash.now[:alert] = "入力内容を確認してください"
      render "cafes/show", status: :unprocessable_entity
    end
  end

  def edit
    authorize_review_owner!
  end

  def update
    authorize_review_owner!
    if @review.update(review_params)
      redirect_to cafe_path(@review.cafe), notice: "レビューを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize_review_owner!
    cafe = @review.cafe
    @review.destroy
    redirect_to cafe_path(cafe), notice: "レビューを削除しました"
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def authorize_review_owner!
    return if @review.user_name == current_user
    redirect_to cafe_path(@review.cafe), alert: "他ユーザーのレビューは操作できません"
  end

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
