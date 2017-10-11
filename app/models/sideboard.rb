class Sideboard < ActiveRecord::Base
	
	include Listable

	belongs_to :deck
	has_many :sideboard_cards
	has_many :cards, through: :sideboard_cards


end