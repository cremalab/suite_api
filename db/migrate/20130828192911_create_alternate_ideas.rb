class CreateAlternateIdeas < ActiveRecord::Migration
  def change
    create_table :alternates do |t|
      t.string :alternate

      t.references :vote, index: true

      t.timestamps
    end
  end
end
