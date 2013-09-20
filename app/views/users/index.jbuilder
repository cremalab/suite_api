json.array! @users do |user|
  json.user_id user.id
  json.name user.display_name
  json.autocomplete_search user.display_name
  json.autocomplete_value user.id
end