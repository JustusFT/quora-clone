# All actions related to user login or registration goes here

post "/signup" do
  user = User.new(params[:user])
  if user.save
    flash[:msg] = "Account successfully created!"
    redirect "/"
  else
    flash[:msg] = "ERROR"
    redirect "/"
  end
end

post "/login" do
  user = User.find_by_email(params[:user][:email])
  # check if valid login
  if User.exists?(user) && user.try(:authenticate, params[:user][:password])
    session["user"] = user.id
    redirect "/"
  else
    flash[:msg] = "Invalid email or password."
    redirect "/"
  end
end

post "/logout" do
  session.delete("user")
  redirect "/"
end
