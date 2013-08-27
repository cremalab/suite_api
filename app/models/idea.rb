class Idea < ActiveRecord::Base
  has_many :ideavotes, foreign_key: "idea_id"
  belongs_to :users

end
