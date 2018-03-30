require 'rails_helper'

RSpec.describe Qcomment, type: :model do
  subject{
		build(:qcomment, user: user)
	}
  	describe "validation" do
   		it "is valid with valid attributes" do
   			expect(subject).to be_valid
   		end
	end
	
	describe "associations" do
		it{ should have_one(:question_id).dependent(:destroy)}
	end
end
