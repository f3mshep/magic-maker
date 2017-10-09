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
		binding.pry
	end

end