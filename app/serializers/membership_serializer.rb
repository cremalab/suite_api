# Public:
#
# Example:
#
#
#
#
#
class MembershipSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :updated_at, :autocomplete_search

  def autocomplete_search
    object.user.display_name
  end
end
