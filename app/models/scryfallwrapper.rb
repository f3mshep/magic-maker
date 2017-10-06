require 'rest-client'
require 'json'

class ScryfallWrapper
	include Searchable

	SEARCH_URL = 'https://api.scryfall.com/cards/search?'

	def search_query(query)
  	SEARCH_URL + query
		#url = base_url + order + query
		#colon =  %3A
		#spaces = +
		#eventually will be a method that allows controller to stick in c:r and this thing will parse it cuz it is badass.
		#method that allows a user to search by type, rules text, or card name
		#optional switches allow user to include cards of a certain color, type, or rarity
		#ordered default by name, optional switches allow to sort by rarity, cost, and CMC
	end

	def browse(query)
		#method that shows user ALL of cards with a given trait, with optional order arguments. 
		#Traits are color, CMC, and set
		#order is default by name, can be price, CMC, or rarity
	end

	def format_finder(legalities_hash)
		formats = ["modern", "standard", "legacy", "commander"]
		legal_in = legalities_hash.select do |format, value|
			formats.include?(format) && value == "legal"
		end
		legal_in.keys.join(" ")
	end

	def current_page(query)
		current_page = query.scan(/\&page=(\d*)/)
		if current_page.first.nil?
			1
		else
			current_page.flatten.first.to_i
		end
	end

	def call(query)
		url = search_query(query)
		#method that returns an array of hashes, each element in the hash represents 
		response = RestClient.get(url)
		json_collection = JSON.parse(response)

		cards = json_collection["data"]

		results = {}
		collection = []
		if !!json_collection["next_page"]
			results[:next_page] =  json_collection["next_page"]
			results[:has_more] = true
			results[:total_cards] = json_collection["total_cards"]
			results[:og_query] ||= query.gsub(/(&page=\d+)/, '')
			results[:current_page] = current_page(query)
		end
		cards.each do |card|
			card_hash = {}
			card_hash[:scryfall_id] = card["id"]
			card_hash[:name] = card["name"]
			card_hash[:image_url] = card["image_uri"]
			card_hash[:rarity] = card["rarity"]
			card_hash[:cmc] = card["cmc"]
			card_hash[:mana_cost] = card["mana_cost"]
			card_hash[:color_identity] =  card["color_identity"]
			card_hash[:card_type] = card["type_line"]
			card_hash[:rules] = card["oracle_text"]
			card_hash[:flavor_text] = card["flavor_text"]
			card_hash[:price] = card["usd"]
			card_hash[:power] = card["power"]
			card_hash[:toughness] = card["toughness"]
			card_hash[:formats] = format_finder(card["legalities"])
			card_hash.delete_if { |key, value| value == nil || value == ""  }
			collection << card_hash
		end

		results[:collection] = collection
		results

	end



end