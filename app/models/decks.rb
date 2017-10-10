class Deck < ActiveRecord::Base

	include Sluggable::InstanceMethods
	extend Sluggable::ClassMethods

	has_many :deck_cards
	belongs_to :user
	has_many :cards, through: :deck_cards

	def decklist
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

	def card_types(type)
		case type
		when "creature"
		when ""
		when condition
		else
		end
		
	end

end