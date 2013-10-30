class CreateBases < ActiveRecord::Migration
  def change
    create_table :bases do |t|

      t.integer :idea_threads
      t.integer :ideas
      t.integer :votes
      t.integer :users
      t.integer :groups
      t.integer :comments

      t.datetime :start_time
      t.datetime :end_time


      t.timestamps
    end
  end
end
