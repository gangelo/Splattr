module Splattr::Operations 
	module Operateable
		attr_reader :operation

		def operation=(value)
			@operation=value
		end
	end
end
