class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(activation_token: params[:token])
    if user && !user.activated
      user.update(activated: true, activated_at: Time.zone.now)
      flash[:success] = "アカウントを承認しました。"
      redirect_to user
    else
      flash.now[:danger] = "無効なリンクです。"
      redirect_to root_path
    end
  end
end
