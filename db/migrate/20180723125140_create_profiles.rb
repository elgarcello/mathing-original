class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.integer :age
      t.string :job
      t.string :hobby
      t.text :comment

      t.timestamps
    end
  end
end
