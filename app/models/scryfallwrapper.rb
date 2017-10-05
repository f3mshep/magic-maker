require 'rest-client'
require 'json'

class ScryfallWrapper
	SEARCH_URL = 'https://api.scryfall.com/cards/search?q='

	def search_query(query)
		input = query.downcase.split.collect{|string|string.scan(/[a-z]/)}
  	input = input.collect {|arr|arr.join("")}.join('+')
  	SEARCH_URL + input
		#url = base_url + order + query
		#colon =  %3A
		#spaces = +

		#method that allows a user to search by type, rules text, or card name
		#optional switches allow user to include cards of a certain color, type, or rarity
		#ordered default by name, optional switches allow to sort by rarity, cost, and CMC
	end

	def browse(query)
		#method that shows user ALL of cards with a given trait, with optional order arguments. 
		#Traits are color, CMC, and set
		#order is default by name, can be price, CMC, or rarity
	end

	def call(query)
		url = search_query(query)
		#method that returns an array of hashes, each element in the hash represents 
		response = RestClient.get(url)
		json_collection = JSON.parse(response)


		cards = json_collection["data"]

		collection = []

		cards.each do |card|
			card_hash = {}
			card_hash[:scryfall_id] = card["id"]
			card_hash[:name] = card["name"]
			card_hash[:image_url] = card["image_uri"]
			card_hash[:rarity] = card["rarity"]
			card_hash[:cmc] = card["cmc"]
			card_hash[:mana_cost] = card["mana_cost"]
			card_hash[:color_identity] =  card["color_identity"]
			card_hash[:type] = card["type_line"]
			card_hash[:rules] = card["oracle_text"]
			card_hash[:flavor_text] = card["flavor_text"]
			card_hash[:price] = card["usd"]
			card_hash[:power] = card["power"]
			card_hash[:toughness] = card["toughness"]
			card_hash.delete_if { |key, value| value == nil || value == ""  }
			collection << card_hash
		end

		collection

	end



end