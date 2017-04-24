get '/question/new' do
  erb :"static/new"
end

post '/question/create' do
  puts "HERE"
  question = Question.new(params[:question])
  question.user_id = current_user.id
  if question.save
    flash[:msg] = "Question successfully saved!"
    redirect "/question/#{question.id}"
  else
    flash[:msg] = "ERROR"
    redirect "/"
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
    flash[:msg] = "Answer successfully saved!"
    redirect "/question/#{params[:id]}"
  else
    flash[:msg] = "ERROR"
    redirect "/question/#{params[:id]}"
  end
end

#
# VOTING
#
post "/question/:id/vote" do
  question = Question.find(params[:id])
  question.vote(current_user, params[:vote_type])
  return erb :"extensions/vote_buttons", layout: false, locals: { instance: question }
end

post "/question/:id/remove-vote" do
  question = Question.find(params[:id])
  question.remove_vote(current_user, params[:id])
  return erb :"extensions/vote_buttons", layout: false, locals: { instance: question }
end
