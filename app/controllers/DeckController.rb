require './config/environment'

class DeckController < ApplicationController
	
	include Searchable

	get '/decks/new' do
		erb :'/decks/new'
	end

	post '/decks/new' do
		collection = Card.create_from_decklist(params[:decklist])
	end

end