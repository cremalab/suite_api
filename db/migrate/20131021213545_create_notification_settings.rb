class CreateNotificationSettings < ActiveRecord::Migration
  def change
    create_table :notification_settings do |t|
      t.boolean :vote
      t.boolean :idea
      t.boolean :idea_thread
      t.boolean :sound
      t.references :user


      t.timestamps
    end
  end
end
