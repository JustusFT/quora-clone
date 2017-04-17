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

#
# VOTING
#
post "/question/:id/upvote" do
  if current_user.vote("upvote", "question", params[:id])
    redirect "/"
  else
    "ERROR"
  end
end

post "/question/:id/downvote" do
  if current_user.vote("downvote", "question", params[:id])
    redirect "/"
  else
    "ERROR"
  end
end

post "/question/:id/remove-vote" do
  if current_user.remove_vote("question", params[:id])
    redirect "/"
  else
    "ERROR"
  end
end
