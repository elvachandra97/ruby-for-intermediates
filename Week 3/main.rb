require 'sinatra'

# ERB TEMPLATING

get '/messages' do
    erb :message, locals: {
        color: 'LightGreen',
        name: 'World'
    }
end

get '/messages/:name' do
    name = params['name']
    color = params['color'] ? params['color'] : 'DodgerBlue'
    erb :message, locals: {
        color: color,
        name: name
    }
end

get '/login' do
    erb :form
end

post '/login' do
    if params['username'] == 'admin' && params['password'] == 'admin'
        return 'Logged in!'
    else
        redirect '/login'
    end
end