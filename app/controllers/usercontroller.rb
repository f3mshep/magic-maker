class UserController < ApplicationController

	get '/users' do
		@users = User.all
	end


	get '/logout' do
		session.clear
		redirect '/login'
	end

	get '/login' do
		redirect '/' if logged_in?
		erb :'/users/login'
	end

	post '/login' do
		user = User.find_by(name: params[:username])
		if user && user.authenticate(params[:password])
		session[:user_id] = user.id
		flash[:success] = "Welcome, #{user.name}"
		redirect '/home'
		#set up flash message to alert user they logged in
		else
		flash[:error] = "Wrong username or password."
		redirect '/login'
		#maybe unhide an element that alerts user they failed??
	end

  end

	get '/signup' do
		erb :'/users/new'
	end

	post '/signup' do
		user = User.new(name: params[:username], password: params[:password])
	    redirect '/signup' if params[:username].empty?
	    if user.save
	      flash[:success] = "Account created."
	      session[:user_id] = user.id
	      redirect '/'
	    else
	      redirect '/signup'
	      flash[:error] = "Error creating account."
	  	end
	end

	get '/users/:slug' do
		@user = find_by_slug(params[:slug])
		erb :'/users/show'
	end

end