# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'base/base_creature'
require 'modules/gender'
require 'shared_spec.rb'

describe BaseCreature do
  before(:each) do
		params = [
			{:gender=>Gender::MALE,:name=>'Gene',:age=>46},
			{:gender=>Gender::FEMALE,:name=>'Amy',:age=>36}
		].shuffle[0]		
    @it = BaseCreature.new params[:gender], params[:name], params[:age]
  end

	it_should_behave_like "creature"
end