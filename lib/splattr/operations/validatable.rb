module Splattr::Operations
	module Validatable
		def valid_operations
			# Override this method with your class-level-specific operations.
			[]
		end

		def valid?(operation)
			!valid_operations.index(operation).nil?
		end
	end
end