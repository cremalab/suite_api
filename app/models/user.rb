class User < ActiveRecord::Base
  authenticates_with_sorcery!

  #Relationships
  has_one :profile, foreign_key: "user_id"
  has_many :ideas, foreign_key: "user_id"
  has_many :voting_rights
  has_many :idea_threads, through: :voting_rights, foreign_key: "user_id"
  has_many :api_keys, foreign_key: "user_id", dependent: :destroy
  has_many :votes, foreign_key: "user_id"
  has_many :memberships, foreign_key: "user_id"
  has_many :groups, through: :membership
  has_many :groups, foreign_key: "owner_id"

  accepts_nested_attributes_for :profile




  #Validations
  validates_associated  :profile, :ideas, :voting_rights, :idea_threads,
                        :api_keys, :memberships, :groups#, :votes


  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :password_confirmation, :on => :create

  validates_presence_of :email
  validates_uniqueness_of :email


  def current_access_token
    self.api_keys.last ? self.api_keys.last.access_token : nil
  end

  def display_name
    if self.profile && self.profile.first_name
      "#{self.profile.first_name}#{self.profile.last_name.empty? ? '' : ' ' + self.profile.last_name}"
    else
      email
    end
  end

end
