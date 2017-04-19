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
  def get_vote(model, id)
    current_user.send("#{model}_votes").find_by("#{model}_id = ?", id)
  end

  def voted?(vote)
    !vote.nil?
  end
end
