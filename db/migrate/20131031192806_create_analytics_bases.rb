class CreateAnalyticsBases < ActiveRecord::Migration
  def change
    create_table :analytics_bases do |t|
      t.integer :idea_thread_creates
      t.integer :idea_thread_updates
      t.integer :idea_thread_deletes

      t.integer :idea_creates
      t.integer :idea_updates
      t.integer :idea_deletes

      t.integer :vote_creates
      t.integer :vote_deletes

      t.integer :comment_creates
      t.integer :comment_updates
      t.integer :comment_deletes

      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
