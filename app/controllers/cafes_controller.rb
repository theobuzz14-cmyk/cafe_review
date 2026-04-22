class CafesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_cafe, only: [:show, :edit, :update, :destroy]

  def index
    @cafes = Cafe.order(created_at: :desc)
  end

  def show
    @reviews = @cafe.reviews.order(created_at: :desc)
    @review = @cafe.reviews.build
  end

  def new
    @cafe = Cafe.new
  end

  def create
    @cafe = Cafe.new(cafe_params)
    if @cafe.save
      redirect_to cafe_path(@cafe), notice: "カフェを登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @cafe.update(cafe_params)
      redirect_to cafe_path(@cafe), notice: "カフェ情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @cafe.destroy
    redirect_to cafes_path, notice: "カフェを削除しました"
  end

  private

  def set_cafe
    @cafe = Cafe.find(params[:id])
  end

  def cafe_params
    params.require(:cafe).permit(:name, :address, :description)
  end
end
