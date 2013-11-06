class AddWinningIdeaAndThresholdToIdeaThread < ActiveRecord::Migration
  def change
    add_column :idea_threads, :threshold, :integer
    add_reference :idea_threads, :winning_idea, index: true

  end
end
