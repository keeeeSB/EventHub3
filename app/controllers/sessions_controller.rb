class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      if user.activated
        reset_session
        log_in user
        flash[:succces] = "ログインしました！"
        redirect_to root_path
      else
        flash.now[:danger] = "アカウントが承認されていません。メールを確認してください。"
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
