post "/answer/:id/comment" do
  # require 'byebug'; byebug
  comment = Comment.new(
    user_id: current_user.id,
    answer_id: params[:id],
    comment: params[:comment][:comment]
  )
  if comment.save
    "SUCCESS"
  else
    "ERROR"
  end
end

post "/comment/:id/vote" do
  @instance = Comment.find(params[:id])
  @instance.vote(current_user, params[:vote_type])
  return erb :"extensions/vote_buttons", layout: false
end

post "/comment/:id/remove-vote" do
  @instance = Comment.find(params[:id])
  @instance.remove_vote(current_user, params[:id])
  return erb :"extensions/vote_buttons", layout: false
end
