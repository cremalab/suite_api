# api_key.rb
#
# This class generates access tokens for the user when he is logs in to the
# site.
#
class ApiKey < ActiveRecord::Base
  #Relationships
  belongs_to :user

  before_create :generate_access_token

private

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end

end