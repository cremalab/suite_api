class AddDescriptionToIdeaThreads < ActiveRecord::Migration
  def change
    add_column :idea_threads, :description, :text
  end
end
