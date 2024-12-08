class JoinsController < ApplicationController

  def create
    join = current_user.joins.build(event_id: params[:event_id])
    if join.save
      flash[:success] = "参加申し込みをしました。"
    else
      flash.now[:danger] = "参加申し込みを出来ませんでした。"
    end
    redirect_to root_path
  end

  def destroy
    join = current_user.joins.find_by(event_id: params[:event_id])
    join.destroy!
    flash[:success] = "参加申し込みを取り消しました。"
    redirect_to root_path, status: :see_other
  end
end
