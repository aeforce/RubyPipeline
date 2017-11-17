class AddOpenEndFieldsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :is_closed, :boolean, default: false
  end
end
