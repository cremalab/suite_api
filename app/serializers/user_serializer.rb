# Public:
#
# Example:
#
#
#
#
#
class UserSerializer < ActiveModel::Serializer
  attributes  :id, :email, :notifications, :auth, :name,
              :logged_in, :autocomplete_search, :autocomplete_value,
              :user_id, :subscription

  has_one :profile

  def auth
    {
      access_token: object.current_access_token,
      user_id: object.id
    }
  end
  def autocomplete_search
    object.display_name
  end

  def autocomplete_value
    object.id
  end

  def logged_in
    true
  end

  def name
    object.display_name
  end

  def user_id
    object.id
  end

end
