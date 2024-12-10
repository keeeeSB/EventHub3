module ApplicationHelper

  def join_button(event)
    return unless event.start_time.future? && event.user != current_user

    join = current_user.joins.find_by(event_id: event.id)
    if join
      link_to "参加取り消し", user_event_join_path(current_user, event, join),
              data: { turbo_method: :delete },
              class: "btn btn-danger btn-sm",
              style: "position: absolute; top: 10px; right: 45px;"
    else
      link_to "参加申し込み", user_event_join_path(current_user, event),
              data: { turbo_method: :post },
              class: "btn btn-outline-success btn-sm",
              style: "position: absolute; top: 10px; right: 45px;"
    end
  end

  def favorite_button(event)
    favorite = current_user.favorites.find_by(event_id: event.id)
    if favorite
      link_to user_event_favorite_path(current_user, event, favorite),
              data: { turbo_method: :delete },
              style: "position: absolute; top: 12px; right: 10px;" do
        image_tag "star-fill.svg"
      end
    else
      link_to user_event_favorite_path(current_user, event),
              data: { turbo_method: :post },
              style: "position: absolute; top: 12px; right: 10px;" do
        image_tag "star.svg"
      end
    end
  end
end
