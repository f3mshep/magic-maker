class AddSideboard < ActiveRecord::Migration[5.1]
  def change

  	create_table :sideboards do |t|
  		t.belongs_to :deck, index: true
  	end

  	create_table :sideboard_cards do |t|
  		t.belongs_to :sideboard
  		t.belongs_to :card
  	end

  end
end
