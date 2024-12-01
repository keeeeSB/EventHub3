class ApplicationController < ActionController::Base
  include SessionsHelper

  def require_login
    unless logged_in?
      flash.now[:warning] = "ログインしてください。"
      redirect_to root_path
    end
  end
end
