post "/answer/:id/vote" do
  Answer.find(params[:id]).vote(current_user, params[:vote_type])
  @model = "answer"
  @id = params[:id]
  @instance = Answer.find(params[:id])
  return erb :"extensions/vote_buttons", layout: false
end

post "/answer/:id/remove-vote" do
  Answer.find(params[:id]).remove_vote(current_user, params[:id])
  @model = "answer"
  @id = params[:id]
  @instance = Answer.find(params[:id])
  return erb :"extensions/vote_buttons", layout: false
end
