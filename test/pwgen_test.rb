require_relative '../lib/ppg'

require 'rspec'

describe PwGen do
	
	before(:each) do
		@pwgen = PwGen.new(8)
		@password = @pwgen.generate_password
	end

	it "should contain 8 digit password" do
		expect(@password.to_s.length).to eq(8)
	end
	it "should be of english chars, downcase" do 
		expect(@password.to_s).to match(/[a-z]+/)
	end
	it "should contain 1 digit" do
		@pwgen.add_mutator(1, Proc.new { Random.rand(10).to_s })
		password = @pwgen.generate_password.to_s
		expect(password).to match(/\D*\d\D*/)
	end
	it "should contain 1 upper case character" do
		@pwgen.add_mutator(1, Proc.new { |c| c.upcase })
		password = @pwgen.generate_password.to_s
		expect(password).to match(/[a-z]*[A-Z][a-z]*/)
	end
end
