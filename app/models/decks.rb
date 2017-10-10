class Deck < ActiveRecord::Base

	include Sluggable::InstanceMethods
	extend Sluggable::ClassMethods

	has_many :deck_cards
	belongs_to :user
	has_many :cards, through: :deck_cards
	has_many :comments
	has_one :sideboard

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

	def cards_of_type(type)
		case type
			when "creature"
				cards =	self.cards.select {|card|card[:card_type].downcase.include?("creature")}
			when "land"
				cards = self.cards.select {|card|card[:card_type].downcase.include?("land")}
			when "spell"
				cards = self.cards.select {|card|!card[:card_type].downcase.include?("creature") && !card[:card_type].downcase.include?("land")}
			else
				cards = self.cards.select {|card|card[:card_type].downcase.include?(type)}
		end
		#this really really really really bothers me. Need to move on though. Refactor later.
		card_count = Hash.new(0)
		cards.each do |card|
			card_count[card] += 1
		end
		
		decklist = ""
		card_count.each do |card, amount|
			decklist << "#{amount}x #{card.name}\n"
		end
		decklist

	end

end