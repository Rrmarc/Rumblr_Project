require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'active_record'
require 'pry'

#classes I created
#require './rb'
#require './.rb'
#require './.rb'
#require './.rb'

register Sinatra::Reloader

get '/' do
    "hellooo"
end
