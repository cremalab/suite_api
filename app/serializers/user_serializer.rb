class UserSerializer < ActiveModel::Serializer
  attributes  :id, :email, :notifications, :current_access_token, :name,
              :autocomplete_search, :autocomplete_value

  has_one :profile

  def name
    object.display_name
  end

  def autocomplete_search
    object.display_name
  end

  def autocomplete_value
    object.id
  end


end
