post "/answer/:id/vote" do
  answer = Answer.find(params[:id])
  answer.vote(current_user, params[:vote_type])
  return erb :"extensions/vote_buttons", layout: false, locals: { instance: answer }
end

post "/answer/:id/remove-vote" do
  answer = Answer.find(params[:id])
  answer.remove_vote(current_user, params[:id])
  return erb :"extensions/vote_buttons", layout: false, locals: { instance: answer }
end
