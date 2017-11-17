class AddUserIdToEventTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :event_types, :user_id, :integer
  end
end
