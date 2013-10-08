class DropTitleFromIdeas < ActiveRecord::Migration
  def change
    remove_column :ideas, :when
  end
end
