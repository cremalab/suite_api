class CreateIdeaVotes < ActiveRecord::Migration
  def change
    create_table :idea_votes do |t|
      t.references :user
      t.references :vote
      t.timestamps
    end
  end
end
