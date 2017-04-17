get '/user/:id' do
  # some code here
  @user = User.find_by_id(params[:id])
  erb :"static/profile"
end
