class SideboardCard < ActiveRecord::Base
	belongs_to :sideboard
	belongs_to :card
end