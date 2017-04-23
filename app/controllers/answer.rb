post "/answer/:id/vote" do
  @instance = Answer.find(params[:id])
  @instance.vote(current_user, params[:vote_type])
  return erb :"extensions/vote_buttons", layout: false
end

post "/answer/:id/remove-vote" do
  @instance = Answer.find(params[:id])
  @instance.remove_vote(current_user, params[:id])
  return erb :"extensions/vote_buttons", layout: false
end
