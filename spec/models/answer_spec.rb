require 'rails_helper'

RSpec.describe Answer, type: :model do
  subject{
		build(:answer, user: user)
	}
  	describe "validation" do
   		it "is valid with valid attributes" do
   			expect(subject).to be_valid
   		end
	end
	describe "associations" do
		it{ should have_one(:user_id).dependent(:destroy)}
	end

	describe "associations" do
		it{ should have_one(:question_id).dependent(:destroy)}
	end
end
