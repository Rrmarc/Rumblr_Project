# Based on http://www.jonathanleighton.com/articles/2011/awesome-active-record-bug-reports/

# Run this script with `bundle exec ruby app.rb`
require 'sqlite3'
require 'active_record'

#require classes
require './models/post.rb'
require './models/user.rb'

# Use `binding.pry` anywhere in this script for easy debugging
require 'pry'

# Connect to a sqlite3 database
# If you feel like you need to reset it, simply delete the file sqlite makes

if ENV['DATABASE_URL']
    ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
 ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'db/rumblr.db'
    )

# Account.create(name: "Rashell", last_name: "Marcelino", birthday:1998-02-06, email: "rashell12@live.com", password: "123pass")

binding.pry

