require 'sinatra'

get '/raga/:name' do
	"Welcome to my page, my name is #{params[:name]}"
end


get '/raga/*/hello/*' do
	"You are trying to access with #{params['splat']}"
end
