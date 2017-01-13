require 'sinatra/base'

class JungleFarmsApp < Sinatra::Application

	get '/' do
		"Welcome to JungleFarms"
	end

	get '/raga/:name' do
		"Welcome to my page, my name is #{params[:name]}"
	end


	get '/raga/*/hello/*' do
		"You are trying to access with #{params['splat']}"
	end
end
