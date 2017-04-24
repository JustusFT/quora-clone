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
  comment = Comment.find(params[:id])
  comment.vote(current_user, params[:vote_type])
  return erb :"extensions/vote_buttons", layout: false, locals: {instance: comment}
end

post "/comment/:id/remove-vote" do
  comment = Comment.find(params[:id])
  comment.remove_vote(current_user, params[:id])
  return erb :"extensions/vote_buttons", layout: false, locals: {instance: comment}
end
