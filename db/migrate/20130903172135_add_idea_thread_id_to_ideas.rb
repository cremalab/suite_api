class AddIdeaThreadIdToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :idea_thread_id, :integer
  end
end
