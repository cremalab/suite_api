class UserSerializer < ActiveModel::Serializer
  attributes  :id, :email, :notifications, :current_access_token, :name,
              :logged_in, :autocomplete_search, :autocomplete_value, :auth

  has_one :profile

  def name
    object.display_name
  end

  def logged_in
    true
  end

  def autocomplete_search
    object.display_name
  end

  def autocomplete_value
    object.id
  end

  def auth
    data              = {}
    data[:access_token] = object.current_access_token
    data[:user_id]      = object.id
    data
  end

end
