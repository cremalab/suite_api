class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title
      t.datetime :when
      t.text :description
      t.references :user, index: true
      t.references :idea_thread, index: true

      t.timestamps
    end
  end
end
