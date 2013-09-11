#Class to pass strings to

class Notifier

  attr_accessor :payload
  def initialize(object, type)
    if type == "Idea"
      @payload = "\'" + object.to_json.to_s + "\'"
    elsif type == "IdeaThread"
      @payload = "\'" + object.to_json.to_s + "\'"
    elsif type == "User"
      @payload = "\'" + object.to_json.to_s + "\'"
    elsif type == "Vote"
      @payload = "\'" + object.to_json.to_s + "\'"
    end



  end

end