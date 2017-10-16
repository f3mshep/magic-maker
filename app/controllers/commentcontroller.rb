class CommentController < ApplicationController

	post '/comments/new' do
		deck = Deck.find_by_slug(params[:deck])
		user = User.find_by_slug(params[:user])
		content = params[:comment]
		new_comment = Comment.create(user: user, deck: deck, content: content)
		redirect "/decks/#{deck.slug}"
	end

	get '/comments/:id' do
		@comment = Comment.find(params[:id].to_i)
		erb :'/comments/show'
	end

	get '/comments/:id/edit' do
		@comment = Comment.find(params[:id].to_i)
		erb :'/comments/edit'
	end

	post '/comments/:id/edit' do
		comment = Comment.find(params[:id].to_i)
		redirect '/login' if comment.user != current_user
		comment.update(content: params[:content])
		redirect "/decks/#{comment.deck.slug}"
	end

	delete '/comments/:id/delete' do
		comment = Comment.find(params[:id].to_i)
		redirect '/login' if comment.user != current_user
		comment.destroy
		redirect "/decks/#{comment.deck.slug}"
	end

end