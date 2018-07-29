class AddSexToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :sex, :string
  end
end
