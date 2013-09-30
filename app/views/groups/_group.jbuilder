json.(group, :id, :name, :created_at, :updated_at, :owner_id)
json.memberships group.memberships, partial: '/memberships/membership', as: :membership
