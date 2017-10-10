class Sideboard < ActiveRecord::Base
	belongs_to :deck
	has_many :sideboard_cards
	has_many :cards, through: :sideboard_cards

	def decklist
		# FIX THIS IT IS NOT DRY :((((
		cards = self.cards.collect {|card|card.name}
		card_count = Hash.new(0)
		cards.each do |card|
			card_count[card] += 1
		end
		
		decklist = ""
		card_count.each do |card, amount|
			decklist << "#{amount}x #{card}\n"
		end
		decklist
	end

end