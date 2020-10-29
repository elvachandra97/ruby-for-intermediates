require 'sinatra'
require './db_connector.rb'

get '/items' do
    items = get_all_items
    erb :items_view, locals: {
        items: items
    }
end

get '/items/new' do
    erb :create
end

post '/items/create' do
    name = params['name']
    price = params['price']
    create_new_item(name, price)
    redirect '/items'
end

