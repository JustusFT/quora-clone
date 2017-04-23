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
post "/question/:id/vote" do
  @instance = Question.find(params[:id])
  @instance.vote(current_user, params[:vote_type])
  return erb :"extensions/vote_buttons", layout: false
end

post "/question/:id/remove-vote" do
  @instance = Question.find(params[:id])
  @instance.remove_vote(current_user, params[:id])
  return erb :"extensions/vote_buttons", layout: false
end
