# All actions related to user login or registration goes here
get "/signup" do
  erb :"static/signup"
end

post "/signup" do
  user = User.new(params[:user])
  if user.save
    "<h1>Account successfully created!</h1><a href='../login'>login</a>"
  else
    "ERROR"
  end
end

get "/login" do
  erb :"static/login"
end

post "/login" do
  user = User.find_by_email(params[:user][:email])
  # check if valid login
  if !user.nil? && user.try(:authenticate, params[:user][:password])
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