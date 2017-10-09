class String
	def to_slug
    binding.pry
    #Takes string, returns slug version of string
    input = self.downcase.split.collect{|string|string.scan(/[a-z0-9]/)}
    input.collect {|arr|arr.join("")}.join('-')
  end
end