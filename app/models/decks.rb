class Deck < ActiveRecord::Base

	include Listable
	include Sluggable::InstanceMethods
	extend Sluggable::ClassMethods

	has_many :deck_cards
	belongs_to :user
	has_many :cards, through: :deck_cards
	has_many :comments
	has_one :sideboard

end