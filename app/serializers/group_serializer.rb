# Public:
#
# Example:
#
#
#
#
#
class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at, :owner_id

  has_many :memberships
end
