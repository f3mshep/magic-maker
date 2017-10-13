require './config/environment'

class CardController < ApplicationController
  
	get '/cards/search/:query' do
  	new_search = ScryfallWrapper.new
    begin
  	 results = new_search.call(params[:query])
    rescue
      flash[:error] = "No results found"
      redirect '/cards/search'
    end

	  if params[:query].include?("&page=") || results[:has_more] == true
	    if @pagination.nil?
	    	total_pages = results[:total_cards] / 175
	      page = 1
		    @pagination = {}
        current_page = new_search.current_page(params[:query])
        @current_page = "#{results[:og_query]}&page=#{current_page}"
        @next_page = "#{results[:og_query]}&page=#{current_page + 1}" unless current_page == total_pages
        @prev_page = "#{results[:og_query]}&page=#{current_page - 1}" unless current_page == 1
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