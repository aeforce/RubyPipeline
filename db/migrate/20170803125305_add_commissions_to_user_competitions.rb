class AddCommissionsToUserCompetitions < ActiveRecord::Migration[5.0]
  def change
    add_column :user_competitions, :master_commission, :float
    add_column :user_competitions, :company_commission, :float
  end
end
