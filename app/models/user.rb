class User < ActiveRecord::Base
  authenticates_with_sorcery!
  before_create :build_profile

  #Relationships
  has_many :api_keys, foreign_key: "user_id", dependent: :destroy
  has_many :comments, foreign_key: "user_id"
  has_many :groups, through: :membership
  has_many :groups, foreign_key: "owner_id"
  has_many :ideas, foreign_key: "user_id"
  has_many :idea_threads, through: :voting_rights, foreign_key: "user_id"
  has_many :memberships, foreign_key: "user_id"
  has_many :votes, foreign_key: "user_id"
  has_many :voting_rights

  has_one :profile, foreign_key: "user_id"

  accepts_nested_attributes_for :profile

  #Validations
  validates_associated  :profile


  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :password_confirmation, :on => :create

  validates_presence_of :email
  validates_uniqueness_of :email

  def current_access_token
    last_key = self.api_keys.last
    last_key ? last_key.access_token : nil
  end

  def display_name
    profile = self.profile
    first_name = profile.first_name
    last_name = profile.last_name

    if profile && first_name
      "#{first_name}" +
      "#{last_name.empty? ? '' : ' ' + last_name}"
    else
      email
    end
  end

  def generate_api_key
    api_keys = self.api_keys

    if api_keys.length > 0
      api_keys.last.destroy
    end

    @api_key = api_keys.create()


  end

  def message
    PrivatePub.publish_to("/message/channel", message: self.to_json)
  end

end
