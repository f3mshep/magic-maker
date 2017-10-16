class Card < ActiveRecord::Base

  include Sluggable::InstanceMethods
  extend Sluggable::ClassMethods

  has_many :deck_cards
  has_many :decks, through: :deck_cards

  has_many :sideboard_cards
  has_many :sideboards, through: :sideboard_cards


  def self.database_scraper(query=nil)
    query = 'as=&order=&q=cmc>0' if query.nil?
    results = ScryfallWrapper.new.call(query)
    Card.create_or_find_from_collection(results[:collection])
    if results[:next_page]
      goto = results[:next_page].scan(/(?<=\?).*/).first
      database_scraper(goto)
    end
  end

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
        return "Invalid entry, please enter an amount between 1-99" if amount > 99 || amount < 1
      else
        amount = 1
        card = items
      end
        begin
          new_card = Card.find_or_create_by_slug(card.to_slug, amount)
          collection << new_card
        rescue
          return "#{card} is not a valid entry"
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

  def self.find_or_create_by_slug(slug, amount=1)
    collection = []
    card = find_by_slug(slug)
    if card.nil?
      new_search = ScryfallWrapper.new
      card_hash = new_search.find_card_by_slug(slug)
      card = Card.find_by(scryfall_id: card_hash[:scryfall_id])
      if card.nil?
        card = Card.create(card_hash)
      end
      amount.times do 
        collection << card
      end
    else
      amount.times do
        collection << card
      end
    end
    collection
  end

end