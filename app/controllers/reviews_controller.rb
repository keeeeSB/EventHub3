class ReviewsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]

  def create
    @review = current_user.build_review(review_params)
    if @review.save
      flash[:success] = "レビューを作成しました。"
    else
      flash.now[:danger] = "レビューを作成できませんでした。"
    end
    redirect_to user_event_path(@event.user, @event)
  end

  def destroy
    @review = Review.find_by(user: current_user, event: @event)
    @review.destroy!
    flash[:success] = "レビューを削除しました。"
    redirect_to user_event_path(@event.user, @event), status: :see_other
  end

  private

    def review_params
      params.require(:review).permit(:body, :rating).merge(event_id: params[:event_id])
    end

    def set_event
      @event = Event.find(params[:event_id])
    end
end
