require 'things/dog'
require 'modules/gender'

class MaleDog < Dog
  def initialize(name,age)
		super Gender::MALE,name,age
  end
end
