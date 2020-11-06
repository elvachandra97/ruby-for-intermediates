require 'sinatra'
require './controllers'

# ITEM
get '/items' do
    controller = ItemController.new
    controller.get_all_item()
end

get '/items/showItemDetail/:id' do
    controller = ItemController.new
    controller.get_item_by_id(params)
end

get '/items/create' do
    controller = ItemController.new
    controller.create_item_page
end

post '/items/createItem' do
    controller = ItemController.new
    controller.create_item(params)
end

get '/items/:id/edit' do
    controller = ItemController.new
    controller.edit_item_page(params)
end

post '/items/:id/editItem' do
    controller = ItemController.new
    controller.edit_item(params)
end

post '/items/deleteItem/:id' do
    controller = ItemController.new
    controller.delete_item(params)
end

# CATEGORY