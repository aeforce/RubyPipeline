class AddPercentageToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :commission, :float
  end
end
