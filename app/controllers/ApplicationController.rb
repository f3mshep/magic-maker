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
    results = new_search.call(params[:query])
    if params[:query].include?("&page=") || results[:has_more] == true
      #current page is either in uri or can be declared as 
      total_pages = results[:total_cards] / 175
      binding.pry
    end
    @pagination = results[:pagination]
  	@collection = Card.new_from_collection(results[:collection])
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