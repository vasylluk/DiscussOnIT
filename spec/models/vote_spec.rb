
require 'rails_helper'

RSpec.describe Vote, type: :model do

let!(:user){create(:user)}

  subject{
		build(:vote, user: user)
	}

  	describe "validation" do
   		it "is not valid with valid params" do
   			expect(subject).to be_valid
   		end
	end
  context "association" do
     it { should belong_to(:user) }
     it { should_not belong_to(:answer) }
     it { should_not belong_to(:question) }
  end
  
end