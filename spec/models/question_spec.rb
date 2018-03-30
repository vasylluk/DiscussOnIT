require 'rails_helper'

RSpec.describe Question, type: :model do
  subject{
		build(:question, user: user)
	}
  	describe "validation" do
   		it "is valid with valid attributes" do
   			expect(subject).to be_valid
   		end
	end

	describe "associations" do
		it{ should have_one(:user_id).dependent(:destroy)}
	end
	
end
