class AddTitlesToIdeaThreads < ActiveRecord::Migration
  def change
    add_column :idea_threads, :title, :string
  end
end
