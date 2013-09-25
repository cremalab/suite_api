class AddStatusToIdeaThreads < ActiveRecord::Migration
  def change
    add_column :idea_threads, :status, :string
  end
end
