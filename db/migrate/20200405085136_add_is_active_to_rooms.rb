class AddIsActiveToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :participants, :is_active, :boolean, after: :status, null: false, default: false
  end
end
