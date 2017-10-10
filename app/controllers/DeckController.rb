require './config/environment'

class DeckController < ApplicationController
	
	include Searchable

	get '/decks' do
		@decks = Deck.all
		erb :'/decks/index'
	end

	get '/decks/new' do
		erb :'/decks/new'
	end

	post '/decks/new' do
		decklist = Card.create_from_decklist(params[:cards])
		deck = Deck.create(name: params[:name], format: params[:format], description: params[:description], )
		deck.cards << decklist
		redirect "/decks/#{deck.slug}/edit"
	end

	get '/decks/:name/edit' do
		@deck = Deck.find_by_slug(params[:name])
		erb :'/decks/edit'
	end

	post '/decks/:name/edit' do
		@deck = Deck.find_by_slug(params[:name])
		decklist = Card.create_from_decklist(params[:cards])
		@deck.update(description: params[:description], format: params[:format])
		
		@deck.cards.clear
		@deck.cards << decklist
		redirect "/decks/#{@deck.slug}/edit"
	end

	get '/decks/:name' do
		@deck = Deck.find_by_slug(params[:name])
		erb :"/decks/show"
	end

	delete '/decks/:name/delete' do
		@deck = Deck.find_by_slug(params[:name])
		@deck.destroy
		redirect '/decks'
	end

end