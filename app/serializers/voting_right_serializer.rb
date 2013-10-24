# Public:
#
# Example:
#
#
#
#
#
class VotingRightSerializer < ActiveModel::Serializer
  attributes  :id, :idea_thread_id, :user_id, :created_at, :autocomplete_value
              :autocomplete_search

  def autocomplete_value
    self.user_id
  end

  def autocomplete_search
    self.voter.display_name
  end
end
