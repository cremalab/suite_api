namespace :attr_update do
  task add_settings: :environment do
    with_set = NotificationSetting.all
    users = User.all
    with_set = with_set.map {|a| a.user}

    without_set = with_set - users

    without_set.map {a.create_notification_setting}

  end

end
