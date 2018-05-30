require 'rails_helper'

RSpec.describe Qcomment, type: :model do

let!(:user){create(:user)}
let!(:question){create(:question)}
  subject{
		build(:qcomment, user: user, question: question)
	}

  	describe "validation" do
   		it "is valid with valid attributes" do
   			expect(subject).to be_valid
   		end
	   	it "is not valid without text field" do
   			subject.text = ""
   			expect(subject).to_not be_valid
   		end
   		it "is not valid without user_id" do
   			subject.user_id = nil
   			expect(subject).to_not be_valid
   		end
   		it "is not valid without question_id" do
   			subject.question_id = nil
   			expect(subject).to_not be_valid
   		end
   		it "is not valid with too short text" do
   			subject.text = "lol"
   			expect(subject).to_not be_valid
   		end
	end
  context "association" do
     it { should belong_to(:user) }
     it { should belong_to(:question)}
  end

end
