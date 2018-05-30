require 'rails_helper'

RSpec.describe ChosenQuestion, type: :model do
let!(:user){create(:user)}
let!(:question){create(:question)}
  subject{
		build(:chosen_question, user: user, question: question)
	}

  	describe "validation" do
   		it "is valid with valid attributes" do
   			expect(subject).to be_valid
   		end
	end
	context "association" do
     it { should belong_to(:user) }
     it { should belong_to(:question)}
  end
end
