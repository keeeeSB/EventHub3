class ReviewsController < ApplicationController

  def create
    event = Event.find_by(id: params[:event_id])
    review = current_user.review.build(review_params)
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
    redirect_to 
  end

  private

    def review_params
      params.require(:review).permit(:body, :rating)
    end
end
