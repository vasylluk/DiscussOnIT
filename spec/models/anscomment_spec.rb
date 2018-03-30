require 'rails_helper'

RSpec.describe Anscomment, type: :model do
  subject{
		build(:ascomment, user: user)
	}
  	describe "validation" do
   		it "is valid with valid attributes" do
   			expect(subject).to be_valid
   		end
	end

	describe "associations" do
		it{ should have_one(:answer_id).dependent(:destroy)}
	end
end
