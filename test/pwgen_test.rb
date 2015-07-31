require_relative '../lib/ppg'

require 'rspec'

describe PwGen do
	
	before(:all) do
		@pwgen = PwGen.new(9)  #9 characters password
		@password = @pwgen.generate
	end

	describe "without mutators" do
		it "should contain 9 digit password" do
			expect(@password.to_s.length).to eq(9)
		end
		it "should be of english chars, downcase" do 
			expect(@password.to_s).to match(/[a-z]+/)
		end
	end
	describe "with mutators" do
		it "should contain 1 upper case character" do
			@pwgen.add_mutator(1, Proc.new { |c| c.upcase })
			password = @pwgen.generate
			expect(password.to_s).to match(/[a-z]*[A-Z][a-z]*/)
		end
		it "should contain 1 digit" do
			@pwgen.add_mutator(1, Proc.new { Random.rand(10).to_s })
			password = @pwgen.generate
			expect(password.to_s).to match(/\D*\d\D*/)
		end
	end
end
