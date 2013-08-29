class CreateAlternateIdeas < ActiveRecord::Migration
  def change
    create_table :alternate_ideas do |t|
      t.string :alternate

      t.references :idea_vote

      t.timestamps
    end
  end
end
