require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'active_record'
require 'pry'
require 'time'


#require classes

require './models/user.rb'
require './models/post.rb'

# Connect to a sqlite3 database
# If you feel like you need to reset it, simply delete the file sqlite makes
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/rumblr.db'
)

register Sinatra::Reloader
enable :sessions
set :session_secret, "eetatasfasdafgG"

get '/' do
  puts session[:user_id]
  if session[:user_id]
    @user = User.find(session[:user_id])
    erb :index
  else
    erb :not_allowed
  end
end

get '/login' do
  erb :login
end



post '/users/login' do
  user = User.find_by(email: params["email"], password: params["password"])

  if user
    session[:user_id] = user.id
    redirect '/users/posts'
  else
    redirect '/login'
  end
end

get '/signup' do
  erb :signup
end

get '/user/post' do
  erb :post
end


post '/user/post' do
postTime = Time.now  
post_instance = Post.create(title: params["post_title"], author: params["author"], post: params["user_post"], post_date: postTime, img: params["user_img"])
#  puts post_instance.inspect
 redirect '/displayPost'
# erb :all_post
  
end

# change this route
get "/displayPost" do

 @blog_post = Post.all 
 
 erb :all_post
end

post '/users/signup' do
  temp_user = User.find_by(email: params["email"])
  if temp_user
    redirect '/login'
  else
    user = User.create(name: params["first_name"], last_name: params["last_name"], birthday: params["birthday"], email: ["email"], password: params["password"])

    puts user.inspect
    user = User.create(email: params["email"], password: params["password"])
    puts user.inspect
    session[:user_id] = user.id
    puts session[:user_id]
    redirect '/'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

# binding.pry

