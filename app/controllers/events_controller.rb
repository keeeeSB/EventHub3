class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def upcoming
    @events = Event.upcoming#.popular
  end

  def past
    @events = Event.past#.avarage_reviews_rating
  end

  def new
    @event = current_user.events.build
    @event.build_category
    @categories = Category.all
  end

  def create
    if event_params[:category_id].present?
      @event = current_user.events.build(event_params.except(:categpry_attributes))
    else
      @event = current_user.events.build(event_params)
    end
    if @event.save
      flash[:success] = "イベントを作成しました。"
      redirect_to root_path
    else
      flash.now[:danger] = "イベントを作成できませんでした。"
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:success] = "イベント情報を更新しました。"
      redirect_to root_path
    else
      flash.now[:danger] = "イベント情報を更新できませんでした。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy!
    flash[:success] = "イベントを削除しました。"
    redirect_to root_path, status: :see_other
  end

  private

    def event_params
      params.require(:event).permit(:title, :description, :start_time,
                                    :location, :category_id, category_attributes: [:id, :name])
    end

    def set_event
      @event = current_user.events.find(params[:id])
    end
end
