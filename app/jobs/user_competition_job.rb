class UserCompetitionJob < ApplicationJob
  queue_as :default

  def perform(response, user_id, competition_id)
    user_competitions = []
    user_competitions << "user_competition_channel_#{user_id}_#{competition_id}"
    ActionCable.server.broadcast_multiple user_competitions, response
  end

end
