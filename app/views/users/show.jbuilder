json.(@user, :id, :email)

json.logged_in @logged_in

json.auth do |json|
  json.access_token @user.current_access_token
  json.user_id @user.id
end