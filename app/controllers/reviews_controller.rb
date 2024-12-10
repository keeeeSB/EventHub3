class ReviewsController < ApplicationController
  before_action :set_event,  only: [:create, :edit, :update, :destroy]
  before_action :set_review, only: [:edit, :update, :destroy]

  def create
    @review = current_user.build_review(review_params)
    if @review.save
      flash[:success] = "レビューを作成しました。"
    else
      flash.now[:danger] = "レビューを作成できませんでした。"
    end
    redirect_to user_event_path(@event.user, @event)
  end

  def edit
  end

  def update
    @review.update(review_params)
    if @review.save
      flash[:success] = "レビューを更新しました。"
    else
      flash[:danger] = "レビューを更新できませんでした。"
    end
    redirect_to user_event_path(@event.user, @event)
  end

  def destroy
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

    def set_review
      @review = Review.find_by(user: current_user, event: @event)
    end
end
