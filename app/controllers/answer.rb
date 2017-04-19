post "/answer/:id/vote" do
  Answer.find(params[:id]).vote(current_user, params[:vote_type])
  redirect "/"
end

post "/answer/:id/remove-vote" do
  Answer.find(params[:id]).remove_vote(current_user, params[:id])
  redirect "/"
end
