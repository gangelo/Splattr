
require "ostruct"
require 'benchmark'

include Benchmark

require 'splattr/splattr'
require 'splattr/constants'
require 'people/male'
require 'people/female'
require 'things/anaconda'
require 'things/male_dog'
require 'things/oak_tree'

gene = Male.new 'gene', 46
gene.extend Splattr

it=gene.dup
it.extend Splattr

amy = Female.new 'Amy', 36
big_anaconda = Anaconda.new Gender::MALE, 46
riley = MaleDog.new 'Riley', 12
oak_tree = OakTree.new 125

module Splattr
	module Operators
	end	
end

=begin
puts "\n\n"
#attributes={:name=>:eq,:gender=>:ne,:age=>:ne}
attributes={:gender=>:ne,:name=>:ne,:age=>:eq}
result = it.splattr_lt(big_anaconda,attributes) do |this,result|
	p result.description
end
p result.result

puts "\n\n"
attributes={:gender=>lambda{|a,b| a==b},:name=>lambda{|a,b| a=="Gene" && b == "Anaconda"},:age=>lambda{|a,b| a>b||a==b}}
result = it.splattr(Splattr::LT,big_anaconda,attributes) do |this,result|
	p result.description
end
p result.result

puts "\n\nArgh\n\n"

name_is_caps=lambda {|a,b| a==b.capitalize}

attributes={:name=>name_is_caps}
if results = it.splattr(Splattr::NE,it,attributes).result
		it.name.capitalize!
end
p results
p it.name
=end

module BankAccount; end

class BaseAccount
	include BankAccount

	def initialize(account_number,account_amount)
		@account_number=account_number
		@account_amount=account_amount
	end
end

class CheckingAccount < BaseAccount; end
class SavingsAccount < BaseAccount; end

module BankAccount
	attr_accessor :account_number
	attr_reader :account_balance

	def account_balance=(value)
		@account_balance=BigDecimal.new(value,2)
	end

	def to_s
		account_type=self.is_a?(CheckingAccount) ? "Chk" : "Sav"
		"#{account_type}: Acct #/Balance: #{@account_number}/$#{@account_balance}"
	end
end

accounts=Array.new

#100.times do
(0...100000).each do |i|
	seed=i+1
	accounts << ((i%2)>0 ? CheckingAccount.new(seed,seed*100) : SavingsAccount.new(seed,seed*100))
	#p "#{accounts[i].to_s}"
end

control_account=accounts.slice!(50)
control_account.extend Splattr


account_balance_test=lambda{|a,b|a.to_f>b.to_f}
#account_balance_test=:eq

require 'profile'

bmbm(15) do |test|
	control_account.ignore_validation=true

	# Dynamic calls...
	test.report("Splattr#splattr(:eq...)") do
		control_account.splattr(:eq,accounts,:account_balance=>account_balance_test).result
	end
	test.report("Splattr#splattr(:lt...)") do
		control_account.splattr(:lt,accounts,:account_balance=>account_balance_test).result
	end
	test.report("Splattr#splattr(:ne...)") do
		control_account.splattr(:ne,accounts,:account_balance=>account_balance_test).result
	end

	# Static calls...
	# eq
	test.report("Splattr#splattr_eq") do
		control_account.splattr_eq(accounts,:account_balance=>account_balance_test).result
	end
	
	#lt
	test.report("Splattr#splattr_lt") do
		control_account.splattr_lt(accounts,:account_balance=>account_balance_test).result
	end
	
	# ne
	test.report("Splattr#splattr_ne") do
		control_account.splattr_ne(accounts,:account_balance=>account_balance_test).result
	end
end


	
