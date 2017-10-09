class CreateDecks < ActiveRecord::Migration[5.1]
  def change
  	create_table :decks do |t|
  		t.string :name
  		t.string :description
  		t.belongs_to :user
  		t.timestamps
  	end
  end
end
