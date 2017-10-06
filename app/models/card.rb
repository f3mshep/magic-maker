class Card < ActiveRecord::Base

  def self.create_or_find_from_collection(card_arr)
    card_arr.collect {|card| Card.find_or_create_by(card)}
  end

  def self.new_from_collection(card_arr)
  	card_arr.collect {|card|Card.new(card)}
  end

end