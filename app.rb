require 'sinatra'
require 'sinatra/reloader'
require 'active_record'
require 'pry'
require 'time'


#require classes

require './models/user.rb'
require './models/post.rb'

# Connect to a sqlite3 database
# If you feel like you need to reset it, simply delete the file sqlite makes
if ENV['DATABASE_URL']
require 'pg'
    ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
require 'sqlite3'
    ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'db/rumblr.db'
    )
end

register Sinatra::Reloader
enable :sessions
set :session_secret, "eetatasfasdafgG"


# _____________________________________________
get '/' do
  puts session[:user_id]
  if session[:user_id]
    @blog_post = Post.all.reverse
    @user = User.find(session[:user_id])
    erb :index
  else
    erb :login
  end
end


get '/login' do
  erb :login
end

# _______________________________________________________
#this will get the information inputed from the form
# checks to see if email and password exist

post '/users/login' do
  user = User.find_by(email: params["email"], password: params["password"])

  if user
    session[:user_id] = user.id
    redirect '/'
  else
    # if user does not exist it will send the back to login page
    redirect '/login'
  end
end
# _______________________________________________________
get '/signup' do
  erb :signup
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
# _______________________________________________________


# _______________________________________________________
# when you click on plus sign button to create a post if not
# logged in then clicking on this "plus" button will send you
# to loggin page.

get '/user/post' do
  if session[:user_id]
    @user = User.find(session[:user_id])
    erb :post
  else
    erb :login
  end
end


post '/user/post' do

  postTime = Time.now
  post_instance = Post.create(name: params["user_post"], post_date: postTime, image: params["user_img"])
  #  puts post_instance.inspect
  redirect '/displayPost'
  # erb :all_post

end



# change this route
get "/displayPost" do
 @user = User.find(session[:user_id])
 @blog_post = @user.posts.all.reverse

#  this will show when click on 'Profile' nav button
 erb :all_post
end


get '/user/post/delete/' do
  "Hello World"
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end


# binding.pry




