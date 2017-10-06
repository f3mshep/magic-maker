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

  #main site navigation
  get '/' do
  end

  #cards

  get '/cards/search/:query' do
  	new_search = ScryfallWrapper.new
  	cards = new_search.call(params[:query])
  	@collection = Card.create_or_find_from_collection(cards)
  	erb :'/cards/results'
  end

  get '/cards/search' do
  	erb :'/cards/card_search'
  end

  post '/cards/search' do
    
  	query = query_generator(params)
  	#include more variables here that can be tacked on to #query such as order and type options
  	redirect "/cards/search/#{query}"
  end





  #decks

  #users

end