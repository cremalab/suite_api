class AddExperationToIdeaThread < ActiveRecord::Migration
  def change
    add_column :idea_threads, :expiration, :datetime
  end
end
