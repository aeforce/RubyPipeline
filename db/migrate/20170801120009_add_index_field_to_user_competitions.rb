class AddIndexFieldToUserCompetitions < ActiveRecord::Migration[5.0]
  def change
    add_column :user_competitions, :index_number, :integer
  end
end
