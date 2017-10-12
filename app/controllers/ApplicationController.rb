require './config/environment'

class ApplicationController < Sinatra::Base
	include Searchable

  configure do
  	enable :sessions
  	set :session_secret, "HERPing-Wh1lE-i-D3333rp"
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Flash
  end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end


  #main site navigation
  get '/' do
    if logged_in?
      redirect '/home'
    end
    erb :'index'
  end

  get '/home' do
    if !logged_in?
      redirect '/login'
    end
    erb :'home'
  end

  #cards

  #decks

  #users

end