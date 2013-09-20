class CreateVotingRights < ActiveRecord::Migration
  def change
    create_table :voting_rights do |t|
      t.belongs_to :user
      t.belongs_to :idea_thread

      t.timestamps
    end
  end
end
