module Splattr
	module Operators
		module Validatable
			def valid_operators
				# Override this method with your class-specific operators.
				[]
			end

			def valid?(operator)
				!valid_operators.index(operator).nil?
			end
		end
	end
end