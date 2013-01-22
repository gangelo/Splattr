module Splattr::Operations
	class CompareOperation < BaseOperation
		def self.valid_operations
			[:eq,:ne,:lt,:gt,:lte,:gte]
		end
	end
end
