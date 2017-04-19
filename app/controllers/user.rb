get '/user/:id' do
  # some code here
  @user = User.find(params[:id])
  erb :"static/profile"
end
