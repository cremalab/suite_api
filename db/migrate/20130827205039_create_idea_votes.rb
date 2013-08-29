class CreateIdeaVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true
      t.references :idea, index: true
      t.string :vote
      t.timestamps
    end
  end
end
