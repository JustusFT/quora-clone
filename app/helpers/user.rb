helpers do
  # This will return the current user, if they exist
  # Replace with code that works with your application
  def current_user
    if session["user"]
      @current_user ||= User.find(session["user"])
    end
  end

  # Returns true if current_user exists, false otherwise
  def logged_in?
    !current_user.nil?
  end

  # get a certain vote from user
  # def get_vote(type, id)
  #   current_user.votes.find_by(type: type, voting_id: id)
  # end
end
