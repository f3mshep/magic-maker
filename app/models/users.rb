class User < ActiveRecord::Base
	
	include Sluggable::InstanceMethods
	extend Sluggable::ClassMethods

	has_many :decks
	has_many :comments

	has_secure_password
end