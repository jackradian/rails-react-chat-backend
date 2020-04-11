class AddIsCurrentToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :participants, :is_current, :boolean, after: :status, null: false, default: false
  end
end
