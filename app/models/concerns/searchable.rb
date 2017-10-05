module Searchable

	def input_parser(query)
		input = query.downcase.split.collect{|string|string.scan(/[a-z]/)}
  	input.collect {|arr|arr.join("")}.join('+')
	end

end