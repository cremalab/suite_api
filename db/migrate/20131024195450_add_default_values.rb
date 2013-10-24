class AddDefaultValues < ActiveRecord::Migration
  def change
    change_column :notification_settings, :vote, :boolean, default: false
    change_column :notification_settings, :idea_thread, :boolean, default: false
    change_column :notification_settings, :idea, :boolean, default: false
    change_column :notification_settings, :sound, :boolean, default: false

  end
end
