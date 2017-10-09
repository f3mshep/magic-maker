class Card < ActiveRecord::Base

  has_many :deck_cards
  has_many :decks, through: :deck_cards

  def self.create_or_find_from_collection(card_arr)
    card_arr.collect {|card| Card.find_or_create_by(card)}
  end

  def self.new_from_collection(card_arr)
  	card_arr.collect do |card|
  		Card.new(card)
  	end
  end

  def slug
		input = self.name.downcase.split.collect{|string|string.scan(/[a-z0-9]/)}
		input.collect {|arr|arr.join("")}.join('-')
	end

	def self.find_by_slug(slug)
		collection = self.all
		collection.find {|instance| instance.slug == slug}
	end

end