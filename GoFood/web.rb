require 'sinatra'
require './db_connector.rb'

get '/items' do
    items = get_all_items
    erb :items_view, locals: {
        items: items
    }
end

get '/items/showItemDetail/:id' do
    id = params['id']
    item = get_item(id)
    erb :items_detail, locals: {
        item: item
    }
end

get '/items/addItem' do
    categories = get_all_categories
    erb :create, locals: {
        categories: categories
    }
end

post '/items/createItem' do
    name = params['name']
    price = params['price']
    create_item(name, price)
    redirect '/items'
end

get '/items/:id/edit' do
    id = params['id']
    item = get_item(id)
    categories = get_all_categories
    erb :edit, locals: {
        item: item,
        categories: categories
    }
end

put '/items/:id/editItem' do
    id = params['id']
    name = params['name']
    price = params['price']
    edit_item(id, name, price)
    redirect '/items'
end

delete '/items/deleteItem/:id' do
    id = params['id']
    delete_item(id)
    redirect '/items'
end