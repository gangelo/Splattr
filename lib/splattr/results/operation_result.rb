require 'splattr/results/result'

module Splattr
=begin rdoc
An OperationResult object is returned for each Splattr operations accepting a block
=end
	class OperationResult < Result
		attr_reader :receiver_object,:compare_object,:property_name,:property_operator
		
		def initialize(receiver_object,operation,compare_object,property_name,property_operator,result)		
			@receiver_object		= receiver_object
			@compare_object			= compare_object
			@property_name			= property_name
			@property_operator	= property_operator
			
			super operation,result			
		end

=begin rdoc
Returns a text description of the resulting Splattr operation
=end
		def description
			desc =
				"Checking for #{@operation}" \
				" ((" \
				"#{@receiver_object.class.name}##{@property_name}" \
				" #{@property_operator}" \
				" #{@compare_object.class.name}##{@property_name}" \
				")" \
				" == #{@result}" \
				")"
			desc
		end
	end
end
