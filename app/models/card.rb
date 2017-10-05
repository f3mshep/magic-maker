class Card < ActiveRecord::Base

  def self.create_or_find_from_collection(card_arr)
    card_arr.collect {|card| Card.find_or_create(card)}
  end

end