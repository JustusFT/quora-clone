enable :sessions

get "/" do
  puts "THIS:"
  puts session["user"]
  puts current_user
  erb :"static/index"
end

get "/byebug" do
  require "byebug"; byebug
end
