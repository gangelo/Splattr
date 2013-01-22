require 'test/unit/assertions'

module Splattr
  module Exceptions
		class InvalidOperationException < ArgumentError; end
		class InvalidOperatorException < ArgumentError; end
  end
end
