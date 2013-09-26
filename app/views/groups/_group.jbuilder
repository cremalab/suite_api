json.(group, :id, :name, :created_at, :updated_at)
json.memberships group.memberships, partial: '/memberships/membership', as: :membership
