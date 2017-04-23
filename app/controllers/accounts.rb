# All actions related to user login or registration goes here

post "/signup" do
  user = User.new(params[:user])
  if user.save
    "Account successfully created!"
  else
    "ERROR"
  end
end

post "/login" do
  user = User.find_by_email(params[:user][:email])
  # check if valid login
  if User.exists?(user) && user.try(:authenticate, params[:user][:password])
    session["user"] = user.id
    redirect "/"
  else
    erb :"static/login"
  end
end

post "/logout" do
  session.delete("user")
  redirect "/"
end
