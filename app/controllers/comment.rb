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
