require './config/environment'

class DeckController < ApplicationController

	get '/decks' do
		@decks = Deck.all
		erb :'/decks/index'
	end

	get '/:user/decks' do
		@decks = User.find_by_slug(params[:user]).decks
		erb :'/decks/index'
	end

	get '/decks/new' do
		redirect '/login' if !logged_in?
		erb :'/decks/new'
	end

	post '/decks/new' do
		redirect '/login' if !logged_in?
		decklist = Card.create_from_decklist(params[:cards])
		if !decklist.is_a?(Array)
			flash[:error] = "#{decklist}"
			redirect "/decks/new"
		end
		sidelist = Card.create_from_decklist(params[:sideboard])
		if !sidelist.is_a?(Array)
			flash[:error] = "#{sidelist}"
			redirect "/decks/new"
		end
		sideboard = Sideboard.create
		sideboard.cards << sidelist
		deck = Deck.create(name: params[:name], format: params[:format], description: params[:description], sideboard: sideboard, user: current_user)
		deck.cards << decklist
		flash[:success] = "Created #{deck.name}"
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
		if !decklist.is_a?(Array)
			flash[:error] = "#{decklist}"
			redirect "/decks/#{@deck.slug}/edit"
		end
		sidelist = Card.create_from_decklist(params[:sideboard])
		if !sidelist.is_a?(Array)
			flash[:error] = "#{sidelist}"
			redirect "/decks/#{@deck.slug}/edit"
		end
		@deck.update(description: params[:description], format: params[:format])
		@deck.sideboard.cards.clear
		@deck.sideboard.cards << sidelist
		@deck.cards.clear
		@deck.cards << decklist
		flash[:success] = "Deck #{@deck.name} updated"
		redirect "/decks/#{@deck.slug}/edit"
	end

	get '/decks/:name' do
		redirect '/login' if !logged_in?
		@user = current_user
		@deck = Deck.find_by_slug(params[:name])
		erb :"/decks/show"
	end

	delete '/decks/:name/delete' do
		redirect '/login' if !logged_in?
		@deck = Deck.find_by_slug(params[:name])
		user = @deck.user.name
		redirect '/login' if current_user != @deck.user
		@deck.destroy
		redirect "/#{@deck.user.slug}/decks"
	end

	post '/decks/card/:slug/add' do
		card = Card.find_by_slug(params[:slug]) 
		deck = Deck.find_by_slug(params[:deck])
		location = params[:location]
		quantity = params[:quantity].to_i
		if location == "side"
			quantity.times do
				deck.sideboard.cards << card
			end
		else
			quantity.times do
				deck.cards << card
			end
		end
		flash[:success] = "#{card.name} added to  <a class='alert-link' href='/decks/#{deck.slug}/edit'>#{deck.name}</a>"
		redirect "/cards/#{card.slug}"
	end

end