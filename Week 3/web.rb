require 'sinatra'

# REST API ROUTING

get '/messages' do
    name = params['name']
    "<h1 style=\"background-color:grey\">Hello World!</h1>"
end

get '/messages/:name' do
    name = params['name']
    "<h1 style=\"background-color:grey;\">Hello #{name}!</h1>"
end

get '/messages/:name/:color' do
    name = params['name']
    color = params['color'] ? params['color'] : 'DodgerBlue'
    "<h1 style=\"background-color:#{color};\">Hello #{name}!</h1>"
end






