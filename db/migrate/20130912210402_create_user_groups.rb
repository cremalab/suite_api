class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|
      t.references :users, index: true
      t.references :users, index: true

      t.timestamps
    end
  end
end
