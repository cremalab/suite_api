class AddExperationToIdeaThread < ActiveRecord::Migration
  def change
    add_column :idea_threads, :experation, :datetime
  end
end
