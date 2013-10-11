class AddIndexesToTables < ActiveRecord::Migration
  def change
    add_index :api_keys, :user_id
    add_index :voting_rights, :user_id
    add_index :voting_rights, :idea_thread_id
  end
end
