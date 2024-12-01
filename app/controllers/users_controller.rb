class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    UserMailer.account_activation(@user).deliver_now
    flash[:info] = "アカウント認証用メールを送信しました！確認してください。"
    redirect_to root_path
  else
    flash.now[:danger] = "登録できませんでした。"
    render :new, status: :unprocessable_entity
  end

  def show
    @user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                   :profile_image, :bio)
    end
end