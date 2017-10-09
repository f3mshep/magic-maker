class Deck < ActiveRecord::Base
	has_many :deck_cards
	belongs_to :user
	has_many :cards, through: :deck_cards
end