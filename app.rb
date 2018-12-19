require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'active_record'
require 'pry'

#require classes

require './models/user.rb'

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
  puts 'tttttttttttt'
  puts session[:user_id]
  if session[:user_id]
    @user = User.find(session[:user_id])
    erb :index
  else
    erb :not_allowed
  end
end

# get '/' do
#   erb :index
# end


# get '/sales' do
#   if session[:user_id]
#     @all_sales = Sale.all.reverse
#     erb :all
#   else
#     erb :not_allowed
#   end

# end

# get '/sales/delete/:id' do
#   Sale.find(params["id"]).destroy
#   redirect '/sales'
# end

# post '/sales' do
#   puts ">>>>>"
#   puts params
#   puts ">>>>>"

#   # make a customer record
#   customer_instance = Customer.create(
#     first_name: params["first_name"],
#     last_name: params["last_name"],
#     gender: params["gender"],
#     phone_number: params["phone_number"],
#     email: params["email"]
#   )
#   # make a car record
#   car_instance = Car.create(
#     make: params["make"],
#     model: params["model"],
#     year: params["year"],
#     sale_markup: params["sale_markup"],
#     cost_price: params["cost_price"]
#   )
#   # make a Transaction with both
#   Sale.create(car: car_instance, customer: customer_instance)

#   redirect '/sales'
# end

get '/login' do
  erb :login
end

post '/users/login' do
  user = User.find_by(email: params["email"], password: params["password"])
  puts ">>>>>>>>>>>>"
  puts user.inspect
  puts ">>>>>>>>>>>>"
  if user
    session[:user_id] = user.id
    redirect '/'
  else
    redirect '/login'
  end
end

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

get '/logout' do
  session[:user_id] = nil
  redirect '/login'
end