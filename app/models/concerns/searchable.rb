module Searchable

	class String
	end

	def query_generator(params)
		query = text_parser(params[:query]) 
		order = order_parser(params[:order])
		set = set_parser(params[:set])
		type = type_parser(params[:type_line])
		colour = colour_parser(params[:color])
		"#{query}#{colour}#{set}#{type}#{order}"
	end

	def colour_parser(colour_input)
		colours = ["w", "u", "b", "r", "g"]
		neg = ""
		multi = ""
		return nil if colour_input.nil?

		if colour_input.include?("del")
			colour_input.delete("del")
			neg = "+-c%3A" + (colours - colour_input).join("")
		end

		if colour_input.include?("m")
			colour_input.delete("m")
			multi = "+c%3Am"
		end

		color_query = "c%3A" + colour_input.join("") + neg + multi
	end

	def text_parser(query)
		input = query.downcase.split.collect{|string|string.scan(/[a-z]/)}
  	input = input.collect {|arr|arr.join("")}.join('+')
  		"q=" + input
	end

	def order_parser(order)
		return "&order=name" if order.nil?
		order
	end

	def set_parser(set)
		return nil if set.empty?
		"+e%3A" + set
	end

	def type_parser(type)
		return nil if type.empty?
		"+t%3A" + type
	end

end