class CreateIdeaThreads < ActiveRecord::Migration
  def change
    create_table :idea_threads do |t|

      t.references :user, index: true

      t.timestamps
    end
  end
end
