class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      if user.activated?
        forwarding_url = session[:forwarding_url]
        reset_session
        log_in user
        flash[:success] = "ログインしました！"
        redirect_to user
      else
        message  = "アカウントが承認されていません。"
        message += "メールを再確認してください。"
        flash[:warning] = message
        redirect_to root_path
      end
    else
      flash.now[:danger] = "メールアドレス、又はパスワードが間違っています。"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    flash[:success] = "ログアウトしました。"
    redirect_to root_path, status: :see_other
  end
end
