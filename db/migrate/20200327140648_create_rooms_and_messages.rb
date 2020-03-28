class CreateRoomsAndMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.integer :room_type, null: false, default: 0

      t.timestamps
    end

    create_table :participants do |t|
      t.references :room, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end

    create_table :messages do |t|
      t.references :room, foreign_key: true, null: false
      t.references :sender, foreign_key: { to_table: :users }, null: false
      t.datetime :sent_at, index: true
      t.text :content

      t.timestamps
    end

    create_table :user_relationships do |t|
      t.references :user_one, foreign_key: { to_table: :users }, null: false
      t.references :user_two, foreign_key: { to_table: :users }, null: false
      t.index [:user_one_id, :user_two_id], unique: true
      t.integer :relationship_type

      t.timestamps
    end
  end
end
