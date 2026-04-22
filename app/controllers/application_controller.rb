class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?

  private

  def current_user
    return nil if session[:current_user_name].blank?
    session[:current_user_name]
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user!
    return if user_signed_in?
    redirect_to new_session_path, alert: "ログインしてください"
  end
end
