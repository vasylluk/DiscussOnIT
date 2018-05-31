require 'rails_helper'

RSpec.describe Category, type: :model do

  subject{
		build(:category)
	}
  	describe "validation" do
      it "is valid with valid attributes" do
        expect(subject).to be_valid
      end  
	   	it "is not valid without text field" do
   			subject.name = nil
   			expect(subject).to_not be_valid
   		end
      it "is not valid with too short text" do
        subject.name = "lol"
        expect(subject).to_not be_valid
      end
	end
	  context "association" do
     it { should have_many(:user_tags) }
     it { should have_many(:tags) }
  end

end
