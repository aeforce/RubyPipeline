class AddPlayNumberToUserCompetitions < ActiveRecord::Migration[5.0]
  def change
    add_column :user_competitions, :play_number, :integer
  end
end
