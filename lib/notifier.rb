#Class to pass strings to

class Notifier

  attr_accessor :payload
  def initialize(object, type)
    if type == "Idea"
      @payload = "\'  " + object + "\'"
    elsif type == "IdeaThread"
      @payload = "\'" + object + "\'"
    elsif type == "User"
      @payload = "\'" + object + "\'"
    elsif type == "Vote"
      @payload = "\'" + object + "\'"
    end



  end

end