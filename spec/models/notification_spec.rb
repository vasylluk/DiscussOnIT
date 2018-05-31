require 'rails_helper'

RSpec.describe Notification, type: :model do

let!(:user){create(:user)}
  
  subject{
		build(:notification, user: user)
	}

  	describe "validation" do
  		it "is valid with valid attributes" do
    		expect(subject).to be_valid
  		end
  
	   	it "is not valid without user_id" do
   			subject.user_id = nil
   			expect(subject).to_not be_valid
   		end
	end
	  context "association" do
     it { should belong_to(:user) }
  end

end
