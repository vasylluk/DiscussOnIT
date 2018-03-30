require 'rails_helper'

RSpec.describe Product, type: :model do
  subject{
		build(:qcomment, user: user)
	}
  	describe "validation" do
   		it "is valid with valid attributes" do
   			expect(subject).to be_valid
   		end
	end
end
