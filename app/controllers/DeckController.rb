require './config/environment'

class DeckController < ApplicationController
	
	include Searchable

	get '/decks/new' do
		erb :'/decks/new'
	end

	post '/decks/new' do
		decklist = Card.create_from_decklist(params[:cards])
	end

end