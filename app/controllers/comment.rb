post "/answer/:id/comment" do
  # require 'byebug'; byebug
  comment = Comment.new
  comment.user_id = current_user.id
  comment.answer_id = params[:id]
  comment.comment = params[:comment][:comment]
  if comment.save
    "SUCCESS"
  else
    "ERROR"
  end
end

post "/comment/:id/vote" do
  Comment.find(params[:id]).vote(current_user, params[:vote_type])
  redirect "/"
end

post "/comment/:id/remove-vote" do
  Comment.find(params[:id]).remove_vote(current_user, params[:id])
  redirect "/"
end
