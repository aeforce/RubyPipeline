class AddInvestmentAmountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :limit_amount, :float, default: 0.0
    add_column :users, :amount_used, :float, default: 0.0
  end
end
