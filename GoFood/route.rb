require 'sinatra'

get '/foodList' do
    erb :foodList
end

get '/addFood' do
    erb :addFood
end

get '/addFood/:foodName' do
    foodName = params['foodName']
    foodPrice = params['foodPrice']
    erb :addSuccess, locals: {
        foodName: foodName,
        foodPrice: foodPrice
    }
end

post '/addFood' do
    if params['foodName'] != '' && (params['foodPrice'] != '0' && params['foodPrice'] != '')
        redirect "/addFood/#{params['foodName']}"
    else
        redirect '/foodList'
    end
end