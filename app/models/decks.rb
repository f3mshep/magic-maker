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
		self.sideboard.cards.each do |card|
			cost += card.price.to_i
		end
		cost
	end

	def color_identity
		the_order = ['White', 'Blue', 'Black' 'Red', 'Green']
		color_matches = []

		colors = {'{W}' =>'White','{U}' => 'Blue','{B}' => 'Black','{R}' => 'Red','{G}' => 'Green'}

		self.cards.each do |card|
			colors.each do |symbol, color|
				next if card.mana_cost.nil?
				if card.mana_cost.include?(symbol)
					color_matches << color
				end
			end
		end
		color_matches << "colorless" if color_matches.empty?
		color_matches.uniq
	end

end