require 'modules/name'
require 'modules/age'

class BaseThingy
	include Name
	include Age

  def initialize(name,age)
		@name=name
		@age=age
  end
end
