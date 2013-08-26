class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :avatar
      t.string :position
      t.text :biography

      t.timestamps
    end
  end
end
