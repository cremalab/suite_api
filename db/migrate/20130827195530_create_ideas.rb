class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title
      t.datetime :when
      t.text :description
      t.references :created_by

      t.timestamps
    end
  end
end
