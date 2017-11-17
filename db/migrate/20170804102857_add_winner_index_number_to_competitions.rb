class AddWinnerIndexNumberToCompetitions < ActiveRecord::Migration[5.0]
  def change
    add_column :competitions, :winner_index_number, :integer
  end
end
