namespace :attr_update do
  task add_settings: :environment do
    with_set = NotificationSetting.all
    users = User.all
    p users
    with_set = with_set.map {|a| a.user}
    p with_set
    without_set = users - with_set

    p without_set
    without_set.map { |a| a.create_notification_setting}
  end

end
