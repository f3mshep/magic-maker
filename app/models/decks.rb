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
		return cost if self.cards.empty?
		self.cards.each do |card|
			next if card.nil?
			cost += card.price.to_i
		end
		 return cost if sideboard.nil?
		self.sideboard.cards.each do |card|
			next if card.nil?
			cost += card.price.to_i
		end
		cost
	end

	def average_cmc
		total_cmc = 0.0
		self.cards.each do |card|
			total_cmc = total_cmc + card.cmc
		end
		binding.pry
		total_cmc / self.total_size
	end

	def total_size
		sideboard_size = 0
		sideboard_size = self.sideboard.cards.size unless self.sideboard.nil?
		self.cards.size + sideboard_size
	end

	def display_text
		self.description.gsub(/\r\n/, '<br>')
	end

	def color_identity
		color_matches = []

		colors = {'{W}' => {'White'=>'https://i.imgur.com/YavuZMp.png'},'{U}' => {'Blue' => 'https://i.imgur.com/8EN6jSv.png'},'{B}' => {'Black'=>'https://i.imgur.com/PMqnD7P.png'},'{R}' => {'Red' => 'https://i.imgur.com/aWGaaQx.png'},'{G}' => {'Green' => 'https://i.imgur.com/I5VJiVL.png'}}

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