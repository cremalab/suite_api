class PublicActivity::ActivitySerializer < ActiveModel::Serializer
  attributes  :id, :created_at, :trackable_id, :trackable_type,
              :recipient_type, :recipient_id, :key, :model_name

  has_one :owner

  def model_name
    "Activity"
  end
end
