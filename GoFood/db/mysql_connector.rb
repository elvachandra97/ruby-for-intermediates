require 'mysql2'
require './models/item.rb'
require './models/category.rb'

def create_db_client
    client = Mysql2::Client.new(
        :host => ENV["DB_HOST"],
        :username => ENV["DB_USERNAME"],
        :password => ENV["DB_PASSWORD"],
        :database => ENV["DB_NAME"]
    )
    client
end