module Listable

	def card_hash(cards=nil)
		cards = self.cards if cards.nil?
		card_count = Hash.new(0)
		cards.each do |card|
			card_count[card] += 1
		end
		card_count
	end

	def list_cards(card_hash=nil)
		card_hash = self.card_hash if card_hash.nil?
		decklist = ""		
		card_hash.each do |card, amount|		
			decklist << "#{amount}x #{card.name}\n"		
		end		
		decklist
	end

	def cards_of_type(type)
		case type
			when "creature"
				cards =	self.cards.select {|card|card[:card_type].downcase.include?("creature")}
			when "land"
				cards = self.cards.select {|card|card[:card_type].downcase.include?("land")}
			when "spell"
				cards = self.cards.select {|card|!card[:card_type].downcase.include?("creature") && !card[:card_type].downcase.include?("land")}
			else
				cards = self.cards.select {|card|card[:card_type].downcase.include?(type)}
		end
		
		card_hash(cards)
	end

end