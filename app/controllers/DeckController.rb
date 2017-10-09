require './config/environment'

class DeckController < ApplicationController
	
	include Searchable

	get '/decks/new' do
		erb :'/decks/new'
	end

	post '/decks/new' do
		decklist = Card.create_from_decklist(params[:cards])
		deck = Deck.create(name: params[:name], description: params[:description])
		deck.cards << decklist
		binding.pry
	end

	get '/decks/:name/edit' do
		
	end

end