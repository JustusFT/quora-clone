enable :sessions

get "/" do
  puts "THIS:"
  puts session["user"]
  puts current_user
  erb :"static/index"
end

get "/signup" do
  erb :"static/signup"
end

post "/signup" do
  user = User.new(params[:user])
  if user.save
    "<h1>Account successfully created!</h1><a href='../login'>login</a>"
  else
    user.errors.messages.to_s
  end
end

get "/login" do
  erb :"static/login"
end

#TODO "move the logic of authenticating a user out of the CONTROLLER into our MODEL"
post "/login" do
  user = User.find_by_email(params[:user][:email])
  if !user.nil? && user.try(:authenticate, params[:user][:password])
    # "SUCCESS"
    session["user"] = user.id
    redirect to("/")
  else
    erb :"static/login"
  end
end

#TODO use post request instead???
get "/logout" do
  session.delete("user")
  redirect to("/")
end

get '/users/:id' do
  # some code here
  @user = User.find_by_id(params[:id])
  erb :"static/profile"
end

get '/question/new' do
  erb :"static/new"
end

post '/question/create' do
  puts "HERE"
  question = Question.new(params[:question])
  question.user_id = current_user.id
  if question.save
    redirect "/"
  else
    "ERROR"
  end
end

get "/question/:id" do
  @question = Question.find(params[:id])
  erb :"static/question"
end

post "/question/:id/answer" do
  @question = Question.find(params[:id])
  answer = Answer.new(params[:answer])
  answer.question_id = @question.id
  answer.user_id = current_user.id
  if answer.save
    redirect to("/question/#{params[:id]}")
  else
    "ERROR"
  end
end

post "/question/:id/upvote" do
  vote = QuestionVote.new
  vote.question_id = params[:id]
  vote.user_id = current_user.id
  if vote.save
    redirect "/"
  else
    "ERROR"
  end
end

post "/question/:id/remove-vote" do
  vote = QuestionVote.find_by("question_id = ? AND user_id = ?", params[:id], current_user.id)
  if vote.destroy
    redirect "/"
  else
    "ERROR"
  end
end
