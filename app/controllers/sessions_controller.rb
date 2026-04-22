class SessionsController < ApplicationController
  def new
  end

  def create
    username = params[:username].to_s.strip

    if username.blank?
      flash.now[:alert] = "ユーザー名を入力してください"
      render :new, status: :unprocessable_entity
      return
    end

    session[:current_user_name] = username
    redirect_to cafes_path, notice: "ログインしました"
  end

  def destroy
    reset_session
    redirect_to cafes_path, notice: "ログアウトしました"
  end
end
