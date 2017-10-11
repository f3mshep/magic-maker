require './config/environment'

class DeckController < ApplicationController

	get '/decks' do
		@decks = Deck.all
		erb :'/decks/index'
	end

	get '/decks/new' do
		redirect '/login' if !logged_in?
		erb :'/decks/new'
	end

	post '/decks/new' do
		redirect '/login' if !logged_in?
		decklist = Card.create_from_decklist(params[:cards])
		sideboard = Sideboard.create
		sidelist = Card.create_from_decklist(params[:sideboard])
		sideboard.cards << sidelist
		deck = Deck.create(name: params[:name], format: params[:format], description: params[:description], sideboard: sideboard, user: current_user)
		deck.cards << decklist
		redirect "/decks/#{deck.slug}/edit"
	end

	get '/decks/:name/edit' do
		redirect '/login' if !logged_in?
		@deck = Deck.find_by_slug(params[:name])
		redirect '/login' if current_user != @deck.user
		erb :'/decks/edit'
	end

	post '/decks/:name/edit' do
		@deck = Deck.find_by_slug(params[:name])
		redirect '/login' if current_user != @deck.user
		decklist = Card.create_from_decklist(params[:cards])
		sidelist = Card.create_from_decklist(params[:sideboard])

		@deck.update(description: params[:description], format: params[:format])
		@deck.sideboard.cards.clear
		@deck.sideboard.cards << sidelist
		@deck.cards.clear
		@deck.cards << decklist
		redirect "/decks/#{@deck.slug}/edit"
	end

	get '/decks/:name' do
		@user = current_user
		@deck = Deck.find_by_slug(params[:name])
		erb :"/decks/show"
	end

	delete '/decks/:name/delete' do
		@deck = Deck.find_by_slug(params[:name])
		redirect '/login' if current_user != @deck.user
		@deck.destroy
		redirect '/decks'
	end

end