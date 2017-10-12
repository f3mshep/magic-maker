class Deck < ActiveRecord::Base

	include Listable
	include Sluggable::InstanceMethods
	extend Sluggable::ClassMethods

	has_many :deck_cards
	belongs_to :user
	has_many :cards, through: :deck_cards
	has_many :comments
	has_one :sideboard

	def price
		cost = 0
		self.cards.each do |card|
			cost += card.price.to_i
		end
		cost
	end

	def color_identity
		colors = []

		self.cards.each do |card|
			colors << card.color_identity
		end
		colors.uniq
	end

end