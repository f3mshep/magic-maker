class CardTable < ActiveRecord::Migration[5.1]
  def change
  	create_table :cards do |t|
  		t.string :scryfall_id
  		t.string :name
  		t.string :image_url
  		t.string :rarity
  		t.float :cmc
  		t.string :mana_cost
  		t.string :color_identity
  		t.string :type
  		t.string :rules
  		t.string :flavor_text
  		t.string :price
  		t.string :power
  		t.string :toughness
  	end
  end
end
