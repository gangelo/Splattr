# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'base/base_creature'
require 'modules/gender'

class Female < BaseCreature
  def initialize(name,age)
		super Gender::FEMALE,name,age
  end
end
