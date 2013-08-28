class CreateIdeaVotes < ActiveRecord::Migration
  def change
    create_table :idea_votes do |t|
      t.references :user
      t.references :idea
      t.timestamps
    end
  end
end
