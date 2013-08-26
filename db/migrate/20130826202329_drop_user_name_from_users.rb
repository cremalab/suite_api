class DropUserNameFromUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :username
    end
  end
end
