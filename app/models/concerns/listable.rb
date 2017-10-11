module Listable

	def card_hash(card_arr=nil)
		card_arr = self.cards if card_arr.nil?
		cards = card_arr.collect {|card|card.name}
		card_count = Hash.new(0)
		cards.each do |card|
			card_count[card] += 1
		end
		card_count
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