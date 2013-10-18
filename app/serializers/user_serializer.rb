class UserSerializer < ActiveModel::Serializer
  attributes  :id, :email, :notifications,  :auth, :name,
              :logged_in, :autocomplete_search, :autocomplete_value

  #Need to add auth somehow

  has_one :profile

  def name
    object.display_name
  end

  def logged_in
    true
  end

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

end
