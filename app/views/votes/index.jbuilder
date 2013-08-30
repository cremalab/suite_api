<<<<<<< HEAD
json.(@vote, :idea_id, :user_id)
=======
json.array! @votes, partial: 'vote', as: :vote
>>>>>>> ab389f648957baaf7c33304b94637032c0ad62a0
