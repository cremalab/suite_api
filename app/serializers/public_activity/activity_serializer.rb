class PublicActivity::ActivitySerializer < ActiveModel::Serializer
  attributes  :id, :created_at, :trackable_id, :trackable_type, :recipient_type, :recipient_id, :key

  has_one :owner
end
