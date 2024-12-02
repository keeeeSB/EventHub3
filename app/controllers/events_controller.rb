class EventsController < ApplicationController

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
  end

  def destroy
  end

  private

    def event_params
      params.require(:event).permit(:title, :description, :start_time,
                                    :location, :category_id)
    end
end
