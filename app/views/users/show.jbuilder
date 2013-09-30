json.(@user, :id, :email, :notifications)

json.logged_in @logged_in
json.subscription @subscription

json.auth do |json|
  json.access_token @user.current_access_token
  json.user_id @user.id
end

json.profile do |json|
  json.partial! '/profiles/profile', profile: @user.profile
end