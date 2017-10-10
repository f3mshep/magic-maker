class Card < ActiveRecord::Base

  include Sluggable::InstanceMethods
  extend Sluggable::ClassMethods

  has_many :deck_cards
  has_many :decks, through: :deck_cards

  has_many :sideboard_cards
  has_many :sideboards, through: :sideboard_cards

  def self.create_or_find_from_collection(card_arr)
    card_arr.collect {|card| Card.find_or_create_by(card)}
  end

  def self.create_from_decklist(decklist)

    collection = []

    decklist.split("\r\n").each do |line_item|
      items = line_item.downcase.split(" ", 2)
      if items.size > 1
        amount = items.first.to_i
        card = items.last
      else
        amount = 1
        card = items
      end
      amount.times do
        collection << Card.find_or_create_by_slug(card.to_slug)
      end
    end

    collection

  end

  def self.create_by_slug(slug)
    new_search = ScryfallWrapper.new
    card_hash = new_search.find_card_by_slug(slug)
    Card.create(card_hash)
  end

  def self.new_from_collection(card_arr)
  	card_arr.collect do |card|
  		Card.new(card)
  	end
  end

  def self.find_or_create_by_slug(slug)
    results = find_by_slug(slug)
    if results.nil?
      create_by_slug(slug)
    else
      results
    end
  end

end