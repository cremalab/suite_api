json.(idea, :id, :title, :description, :when)
json.user do
  json.email idea.user.email
  json.id idea.user.id
end