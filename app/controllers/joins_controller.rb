class JoinsController < ApplicationController

  def index
    @join_events = current_user.join_events.order(start_time: :asc)
  end

  def create
    join = current_user.join.build(event_id: params[:event_id])
    if join.save
      flash[:success] = "参加申し込みをしました。"
    else
      flash.now[:danger] = "参加申し込みを出来ませんでした。"
    end
    redirect_to root_path
  end

  def destroy
    join = current_user.join.find_by(event_id: params[:event_id])
    join.destroy!
    flash[:success] = "参加申し込みを取り消しました。"
    redirect_to root_path, status: :see_other
  end
end
