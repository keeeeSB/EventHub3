class ReviewsController < ApplicationController
  before_action :set_event

  def create
    review = current_user.review.build(event_id: params[:event_id], review_params)
    if review.save
      flash[:success] = "レビューを作成しました。"
    else
      flash.now[:danger] = "レビューを作成できませんでした。"
    end
    redirect_to user_event_path(event.user)
  end

  def destroy
    review = current_user.review.find_by(event_id: params[:event_id])
    review.destroy!
    flash[:success] = "レビューを削除しました。"
    redirect_to user_event_path(event.user), status: :see_other
  end

  private

    def review_params
      params.require(:review).permit(:body, :rating)
    end

    def set_event
      event = Event.find_by(id: params[:event_id])
    end
end
