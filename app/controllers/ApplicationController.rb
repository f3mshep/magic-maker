require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
  	enable :sessions
  	set :session_secret, "HERPing-Wh1lE-i-D3333rp"
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Flash
  end

end