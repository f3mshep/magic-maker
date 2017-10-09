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
		redirect "/decks/#{deck.slug}/edit"
	end

	get '/decks/:name/edit' do
		deck = Deck.find_by_slug(params[:name])
		binding.pry
	end

end