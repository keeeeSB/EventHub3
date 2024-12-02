class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(evennt_params)
    if @event.save
      flash[:success] = "イベントを作成しました。"
      redirect_to root_oath
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
                                    :location, :category_id)
    end

    def set_event
      @event = current_user.events.find(params[:id])
    end
end
