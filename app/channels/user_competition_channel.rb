class UserCompetitionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_competition_channel_#{current_user.id}_#{params[:comp_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
