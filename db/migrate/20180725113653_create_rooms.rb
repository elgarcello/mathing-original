class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.references :user, foreign_key: true
      t.references :guest, foreign_key: { to_table: :users } 

      t.timestamps
      t.index [:user_id, :guest_id], unique: true
    end
  end
end
