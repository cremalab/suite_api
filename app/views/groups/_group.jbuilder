json.(group, :id, :name, :created_at, :updated_at)
json.membership group.memberships, partial: '/memberships/membership', as: :membership
