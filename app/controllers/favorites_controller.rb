class FavoritesController < ApplicationController

  def index
    @favorite_events = current_user.favorite_events.order(start_time: :asc)
  end

  def create
    favorite = current_user.favorites.build(event_id: params[:event_id])
    if favorite.save
      flash[:success] = "お気に入りに登録しました。"
    else
      flash.now[:danger] = "お気に入りに登録できませんでした。"
    end
    redirect_to root_path
  end

  def destroy
    favorite = current_user.favorites.find_by(event_id: params[:event_id])
    favorite.destroy!
    flash[:success] = "お気に入りを解除しました。"
    redirect_to root_path, status: :see_other
  end
end
