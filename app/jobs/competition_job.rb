class CompetitionJob < ApplicationJob
  queue_as :default

  def perform(response, competition_id)
    competitions = []
    competitions << "competition_channel_#{competition_id}"
    ActionCable.server.broadcast_multiple competitions, response
  end
end
