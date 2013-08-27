class CreateFKforProfile < ActiveRecord::Migration
  def change
    change_table :profiles do |t|
      t.remove :user_id
      t.references :user
    end
  end
end
