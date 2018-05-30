require 'rails_helper'

RSpec.describe Question, type: :model do
let!(:user){create(:user)}

  subject{
		build(:question, user: user)
	}
  	
  	describe "validation" do
      it "is valid with valid attributes" do
        expect(subject).to be_valid
      end
      it "is not valid without text field" do
        subject.text = ""
        expect(subject).to_not be_valid
      end 
      it "is not valid without name field" do
        subject.name = ""
        expect(subject).to_not be_valid
      end
      it "is not valid without user_id" do
        subject.user_id = nil
        expect(subject).to_not be_valid
      end
      it "is not valid with too short text" do
        subject.text = "lol"
        expect(subject).to_not be_valid
      end
      it "is not valid with too short name" do
        subject.name = "lol"
        expect(subject).to_not be_valid
      end
  	end
  	
  	context "association" do
     it { should belong_to(:user) }
     it { should have_many(:qcomments) }
     it { should have_many(:answers) }
     it { should have_many(:chosen_questions) }
  	end
end
