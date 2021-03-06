require 'sinatra/base'
require 'pony'
require 'json'
require 'pry'

class JungleFarmsApp < Sinatra::Application

	#filters for all
	before do
		request.body.rewind
		@request_json = JSON.parse request.body.read
		puts "hi, I am in before of all"
	end

	#filters for each
	before '/accounts' do
		#authenticate!
		puts "hi, I am in before of accounts"
	end

	#handlers
	post '/accounts' do
	#get '/accounts' do
		puts "hi, I am in post accounts"
		redirect '/sessions'
	end
	
=begin
	post '/accounts' do
		#request.body
		#binding.pry	
		#request.body['email_address']
		
		#send activation email
		Pony.mail(:to => @request_json['email_address'], :from => 'ragavendra.bn@linuxflavour.com', :subject => 'Email verification', :body => 'Click here to activate your account')
	end
=end

	post '/sessions' do
		puts "hi, I am in post sessions"
		request.body
	end

enable :sessions

	get '/sessions' do
		  
		session['counter'] ||= 0
		session['counter'] += 1
		"You've hit this page #{session['counter']} times!" 
		
		puts "hi, I am in get sessions for #{session['counter']} times!"
	end

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

	#more of an exception handler kind for invalid URL POSTs
	post '/*' do
		request.body
	end

end
