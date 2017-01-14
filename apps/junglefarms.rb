require 'sinatra/base'

class JungleFarmsApp < Sinatra::Application

	get '/' do
		haml :index
		"Welcome to JungleFarms"
	end

	get '/about' do
		haml :about
		"About JungleFarms"
	end
	
	get '/raga/:name' do
		haml :raga
		"Welcome to my page, my name is #{params[:name]}"
	end


	get '/raga/*/hello/*' do
		"You are trying to access with #{params['splat']}"
	end
	
	get '/dogs' do
		# get a listing of all the dogs
	end

	get '/dog/:id' do
		# just get one dog, you might find him like this:
		@dog = Dog.find(params[:id])
		# using the params convention, you specified in your route
	end

	post '/dog' do
		# create a new dog listing
	end

	put '/dog/:id' do
		# HTTP PUT request method to update an existing dog
	end

	delete '/dog/:id' do
		# HTTP DELETE request method to remove a dog who's been sold!
	end

end
