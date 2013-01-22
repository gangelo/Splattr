module Splattr::Operations
  class LogicalOperation < BaseOperation
		def self.valid_operations
			[:and,:or,:not]
		end
	end
end
