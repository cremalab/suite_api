class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title
      t.datetime :when
      t.text :description
      t.references :user

      t.timestamps
    end
  end
end
