require './config/environment'

class CardController < ApplicationController
  
	get '/cards/search/:query' do
  	new_search = ScryfallWrapper.new
  	results = new_search.call(params[:query])

	  if params[:query].include?("&page=") || results[:has_more] == true
	    if @pagination.nil?
	    	total_pages = results[:total_cards] / 175
	      page = 1
		    @pagination = {}
		    total_pages.times do
		      @pagination[page] = "#{results[:og_query]}&page=#{page}"
		      page += 1
		    end
		  end
	  end

  	@collection = Card.create_or_find_from_collection(results[:collection])
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

  get '/cards/:slug' do
    @card = Card.find_by_slug(params[:slug])
    erb :'/cards/card'
  end


end